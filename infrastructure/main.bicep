param location string = resourceGroup().location
param storageAccountName string
param cdnProfileName string
param cdnEndpointName string
param cdnEndpointOriginHostHeader string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    staticWebsite: {
      enabled: true
      indexDocument: 'index.html'
      errorDocument404Path: '404.html'
    }
  }
}

resource cdnProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: cdnProfileName
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  name: cdnEndpointName
  parent: cdnProfile
  location: location
  properties: {
    origins: [
      {
        name: 'origin1'
        hostName: cdnEndpointOriginHostHeader
      }
    ]
    isHttpAllowed: true
    isHttpsAllowed: true
    isCompressionEnabled: true
    contentTypesToCompress: [
      'text/html'
      'text/css'
      'application/javascript'
      'application/json'
      'image/svg+xml'
    ]
  }
}
