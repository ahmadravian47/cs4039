@description('Name of the first virtual network')
param vnet1Name string = 'vnet-1'

@description('Name of the second virtual network')
param vnet2Name string = 'vnet-2'

@description('Azure region to deploy resources')
param location string = resourceGroup().location

@description('Log Analytics Workspace ID for diagnostics')
param workspaceId string

resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'infra'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'storage'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'infra'
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
      {
        name: 'storage'
        properties: {
          addressPrefix: '10.1.2.0/24'
        }
      }
    ]
  }
}

// Diagnostic settings omitted here for brevity
// (You can leave in the diagnosticSettings from earlier)

output vnet1InfraSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet1.name, 'infra')
output vnet2InfraSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet2.name, 'infra')
