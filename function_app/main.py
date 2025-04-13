import os
import json
import logging
import azure.functions as func
from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        # Get the connection string from environment variables
        connection_string = os.environ['AzureWebJobsStorage']
        
        # Create the TableService object
        table_service = TableService(connection_string=connection_string)
        
        # Read the entity with partition key '1' and row key 'counter'
        entity = table_service.get_entity('YourTableName', '1', 'counter')
        
        # Increment the 'count' field by 1
        entity['count'] += 1
        
        # Update the entity in the table
        table_service.update_entity('YourTableName', entity)
        
        # Return a JSON response with the updated count
        return func.HttpResponse(
            json.dumps({'count': entity['count']}),
            mimetype="application/json"
        )
    except Exception as e:
        logging.error(f"An error occurred: {e}")
        return func.HttpResponse(
            json.dumps({'error': 'An error occurred while processing your request.'}),
            status_code=500,
            mimetype="application/json"
        )
