@description('Storage account for VNet1')
param storage1Name string

@description('Storage account for VNet2')
param storage2Name string

@description('Location for both storage accounts')
param location string

@description('Log Analytics Workspace ID for diagnostics')
param workspaceId string

resource storage1 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storage1Name
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource storage2 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storage2Name
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// Diagnostic for storage1
resource storage1Diag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'storage1-diagnostics'
  scope: storage1
  properties: {
    workspaceId: workspaceId
    metrics: [
      {
        category: 'Transaction'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    logs: [
      {
        category: 'StorageRead'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
      {
        category: 'StorageWrite'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
}

// Diagnostic for storage2
resource storage2Diag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'storage2-diagnostics'
  scope: storage2
  properties: {
    workspaceId: workspaceId
    metrics: [
      {
        category: 'Transaction'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    logs: [
      {
        category: 'StorageRead'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
      {
        category: 'StorageWrite'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
}
