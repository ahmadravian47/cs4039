param location string = resourceGroup().location

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'cs4037-law'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

module vnetModule 'modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    location: location
    vnet1Name: 'myVnet1'
    vnet2Name: 'myVnet2'
    workspaceId: logAnalytics.id
  }
}

// Extract subnet IDs from vnet outputs
var vnet1InfraSubnetId = vnetModule.outputs.vnet1InfraSubnetId
var vnet2InfraSubnetId = vnetModule.outputs.vnet2InfraSubnetId

module peering 'modules/peering.bicep' = {
  name: 'peeringDeployment'
  params: {
    location: location
  }
}

// Example: pass subnetId into a VM module
// module vmModule 'modules/vm.bicep' = {
//   name: 'vmDeployment'
//   params: {
//     subnetId: vnet1InfraSubnetId
//   }
// }
