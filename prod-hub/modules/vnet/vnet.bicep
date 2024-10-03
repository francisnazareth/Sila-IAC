param vnetName string
param vnetAddressPrefix string

param bastionSubnetAddressPrefix string
param location string = resourceGroup().location

param managementSubnetName string
param managementSubnetAddressPrefix string
param sharedServicesSubnetName string
param sharedServicesSubnetAddressPrefix string
param ddosProtectionPlanId string
param ddosProtectionPlanEnabled bool = true
param tagValues object
param vmNSGName string 
param peSubnetName string
param peSubnetAddressPrefix string


param fgIntSubnetAddressPrefix string
param fgExtSubnetAddressPrefix string
param fgMgmtSubnetAddressPrefix string
param fgHASubnetAddressPrefix string 

param paExtSubnetAddressPrefix string
param paIntSubnetAddressPrefix string
param paMgmtSubnetAddressPrefix string
param paHASubnetAddressPrefix string

param f5ExtSubnetAddressPrefix string
param f5IntSubnetAddressPrefix string
param f5MgmtSubnetAddressPrefix string
param f5HASubnetAddressPrefix string
param adSubnetAddressPrefix string 

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: vmNSGName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  tags: tagValues
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }

    subnets: [
      {
        name: 'snet-FGext-sila-hub-qc-01'
        properties: {
          addressPrefix: fgExtSubnetAddressPrefix
        }
      }
      {
        name: 'snet-FGint-sila-hub-qc-01'
        properties: {
          addressPrefix: fgIntSubnetAddressPrefix
        }
      }
      {
        name: 'snet-FGmgmt-sila-hub-qc-01'
        properties: {
          addressPrefix: fgMgmtSubnetAddressPrefix
        }
      }
      {
        name: 'snet-FGHA-sila-hub-qc-01'
        properties: {
          addressPrefix: fgHASubnetAddressPrefix
        }
      }


      {
        name: 'snet-PAext-sila-hub-qc-01'
        properties: {
          addressPrefix: paExtSubnetAddressPrefix
        }
      }
      {
        name: 'snet-PAint-sila-hub-qc-01'
        properties: {
          addressPrefix: paIntSubnetAddressPrefix
        }
      }
      {
        name: 'snet-PAmgmt-sila-hub-qc-01'
        properties: {
          addressPrefix: paMgmtSubnetAddressPrefix
        }
      }
      {
        name: 'snet-PAHA-sila-hub-qc-01'
        properties: {
          addressPrefix: paHASubnetAddressPrefix
        }
      }

      {
        name: 'snet-F5ext-sila-hub-qc-01'
        properties: {
          addressPrefix: f5ExtSubnetAddressPrefix
        }
      }
      {
        name: 'snet-F5int-sila-hub-qc-01'
        properties: {
          addressPrefix: f5IntSubnetAddressPrefix
        }
      }
      {
        name: 'snet-F5mgmt-sila-hub-qc-01'
        properties: {
          addressPrefix: f5MgmtSubnetAddressPrefix
        }
      }
      {
        name: 'snet-F5HA-sila-hub-qc-01'
        properties: {
          addressPrefix: f5HASubnetAddressPrefix
        }
      }





      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: bastionSubnetAddressPrefix
        }
      }      
    
      {
        name: peSubnetName
        properties: {
          addressPrefix: peSubnetAddressPrefix
        }
      }
   
      {
        name: managementSubnetName
        properties: {
          addressPrefix: managementSubnetAddressPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }

      {
        name: sharedServicesSubnetName
        properties: {
          addressPrefix: sharedServicesSubnetAddressPrefix
        }
      }

      {
        name: 'snet-ad-sila-hub-qc-01'
        properties: {
          addressPrefix: adSubnetAddressPrefix
        }
      }

    ]

    enableDdosProtection: ddosProtectionPlanEnabled
    ddosProtectionPlan: {
      id: ddosProtectionPlanId
    }
  }

  resource bastionSubnet 'subnets' existing = {
      name: 'AzureBastionSubnet'
  }

  resource managementSubnet 'subnets' existing = {
      name: managementSubnetName
  }

  resource sharedServicesSubnet 'subnets' existing = {
      name: sharedServicesSubnetName
  }

  
}

output vnetId string = vnet.id
output bastionSubnetID string = vnet::bastionSubnet.id
output managementSubnetID string = vnet::managementSubnet.id
output sharedServicesSubnetID string = vnet::sharedServicesSubnet.id
