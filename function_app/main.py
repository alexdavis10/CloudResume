import logging
import azure.functions as func
import os
from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Retrieve the connection string from environment variables
    connection_string = os.getenv('AzureWebJobsStorage')
    table_service = TableService(connection_string=connection_string)
    table_name = 'VisitorCount'

    # Check if the table exists, if not create it
    if not table_service.exists(table_name):
        table_service.create_table(table_name)

    # Retrieve the visitor count entity
    visitor_count_entity = table_service.get_entity(table_name, '1', '1')

    # Update the visitor count
    visitor_count = int(visitor_count_entity['count'])
    visitor_count += 1
    visitor_count_entity['count'] = visitor_count
    table_service.update_entity(table_name, visitor_count_entity)

    # Return the updated visitor count
    return func.HttpResponse(
        body=f'{{"count": {visitor_count}}}',
        status_code=200,
        mimetype="application/json"
    )
