import unittest
from unittest.mock import patch, MagicMock
import azure.functions as func
import main

class TestFunction(unittest.TestCase):
    @patch('main.TableService')
    @patch('main.os.getenv')
    def test_visitor_count(self, mock_getenv, mock_table_service):
        # Mock environment variable
        mock_getenv.return_value = 'fake_connection_string'

        # Mock TableService
        mock_table_service_instance = MagicMock()
        mock_table_service.return_value = mock_table_service_instance

        # Mock entity
        mock_entity = {'count': '1'}
        mock_table_service_instance.get_entity.return_value = mock_entity

        # Create a mock HTTP request
        req = func.HttpRequest(
            method='GET',
            url='/api/visitorCount',
            body=None
        )

        # Call the function
        resp = main.main(req)

        # Check the response
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.get_body().decode(), '{"count": 2}')

        # Check if the entity was updated
        updated_entity = {'count': 2}
        mock_table_service_instance.update_entity.assert_called_once_with('VisitorCount', updated_entity)

if __name__ == '__main__':
    unittest.main()
