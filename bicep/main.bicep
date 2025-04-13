param location string = resourceGroup().location
param functionAppName string
param storageAccountName string
param cosmosDbAccountName string
param cosmosDbDatabaseName string
param cosmosDbContainerName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource functionApp 'Microsoft.Web/sites@2021-02-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storageAccount.properties.primaryEndpoints.blob
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
        {
          name: 'AzureCosmosDBConnectionString'
          value: cosmosDbAccount.properties.connectionStrings[0].connectionString
        }
      ]
    }
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'appServicePlan'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-04-01' = {
  name: cosmosDbAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    capabilities: [
      {
        name: 'EnableTable'
      }
    ]
  }
}

resource cosmosDbDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-04-01' = {
  name: '${cosmosDbAccountName}/${cosmosDbDatabaseName}'
  location: location
  properties: {
    resource: {
      id: cosmosDbDatabaseName
    }
  }
  dependsOn: [
    cosmosDbAccount
  ]
}

resource cosmosDbContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-04-01' = {
  name: '${cosmosDbAccountName}/${cosmosDbDatabaseName}/${cosmosDbContainerName}'
  location: location
  properties: {
    resource: {
      id: cosmosDbContainerName
      partitionKey: {
        paths: ['/partitionKey']
        kind: 'Hash'
      }
    }
  }
  dependsOn: [
    cosmosDbDatabase
  ]
}

output functionAppName string = functionApp.name
output storageAccountName string = storageAccount.name
output cosmosDbAccountName string = cosmosDbAccount.name
output cosmosDbDatabaseName string = cosmosDbDatabase.name
output cosmosDbContainerName string = cosmosDbContainer.name
