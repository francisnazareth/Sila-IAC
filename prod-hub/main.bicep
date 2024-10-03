targetScope = 'subscription'

param location string = 'qatarcentral'
param vnetName string
param vnetAddressPrefix string
param bastionSubnetAddressPrefix string
param peSubnetName string
param peSubnetAddressPrefix string 

param managementSubnetName string
param managementSubnetAddressPrefix string
param sharedServicesSubnetName string
param sharedServicesSubnetAddressPrefix string
param vmNSGName string 
param bastionName string 
param bastionPublicIPName string 
param bastionSku string
param logAnalyticsRetentionInDays int 
param logAnalyticsWorkspaceName string 
param logAnalyticsSku string
param ddosProtectionPlanName string 
@description('Enable DDoS protection plan.')
param ddosProtectionPlanEnabled bool 

param availabilityZones array 
param vmName string
param vmSize string
param adminUsername string
@secure()
param adminPassword string
param tagValues object
param backupRGName string 
param managementRGName string 
param monitoringRGName string
param networkRGName string
param recoveryServiceVaultName string 
param managedIdentityName string
param keyVaultName string 
param keyVaultSKU string 


resource backupRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: backupRGName
  location: location
  tags: tagValues
}

resource managementRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: managementRGName
  location: location
  tags: tagValues
}

resource monitoringRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: monitoringRGName
  location: location
  tags: tagValues
}

resource networkRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: networkRGName
  location: location
  tags: tagValues
}

module ddosProtectionPlan 'modules/ddos/ddos.bicep' = {
  name: 'ddosProtectionPlan'
  scope: networkRG
  params: {
    location: location
    ddosProtectionPlanName: ddosProtectionPlanName
    ddosPlanEnabled: ddosProtectionPlanEnabled
    tagValues: tagValues
  }
}

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

module vnet './modules/vnet/vnet.bicep' = {
  name: 'vnet'
  scope: networkRG
  params: {
    vnetName: vnetName
    location: location
    vnetAddressPrefix: vnetAddressPrefix

    fgIntSubnetAddressPrefix: fgIntSubnetAddressPrefix
    fgExtSubnetAddressPrefix: fgExtSubnetAddressPrefix
    fgMgmtSubnetAddressPrefix: fgMgmtSubnetAddressPrefix
    fgHASubnetAddressPrefix: fgHASubnetAddressPrefix 
    
    paExtSubnetAddressPrefix: paExtSubnetAddressPrefix
    paIntSubnetAddressPrefix: paIntSubnetAddressPrefix
    paMgmtSubnetAddressPrefix: paMgmtSubnetAddressPrefix
    paHASubnetAddressPrefix: paHASubnetAddressPrefix
    
    f5ExtSubnetAddressPrefix: f5ExtSubnetAddressPrefix
    f5IntSubnetAddressPrefix: f5IntSubnetAddressPrefix
    f5MgmtSubnetAddressPrefix: f5MgmtSubnetAddressPrefix
    f5HASubnetAddressPrefix: f5HASubnetAddressPrefix

    bastionSubnetAddressPrefix: bastionSubnetAddressPrefix
    peSubnetName: peSubnetName
    peSubnetAddressPrefix: peSubnetAddressPrefix
    managementSubnetName: managementSubnetName
    managementSubnetAddressPrefix: managementSubnetAddressPrefix
    sharedServicesSubnetName: sharedServicesSubnetName
    sharedServicesSubnetAddressPrefix: sharedServicesSubnetAddressPrefix
    ddosProtectionPlanId: ddosProtectionPlan.outputs.ddosProtectionPlanId
    ddosProtectionPlanEnabled: ddosProtectionPlanEnabled
    tagValues: tagValues
    vmNSGName: vmNSGName
  }
}

module bastion './modules/bastion/bastion.bicep' = {
  name: 'bastion'
  scope: managementRG
  params: {
    location: location
    bastionSubnetID: vnet.outputs.bastionSubnetID
    bastionName: bastionName
    bastionPublicIPName: bastionPublicIPName
    bastionSku: bastionSku
    tagValues: tagValues   
    availabilityZones: availabilityZones
  }
}

module logAnalytics './modules/logAnalytics/logAnalytics.bicep' = {
  name: 'logAnalytics'
  scope: monitoringRG
  params: {
    location: location
    tagValues: tagValues
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    logAnalyticsSku: logAnalyticsSku
    logAnalyticsRetentionInDays: logAnalyticsRetentionInDays
  }
}



/*module routeTable './modules/routeTable/routeTable.bicep' = {
  name: 'routeTable'
  scope: networkRG
  dependsOn: [firewall]
  params: {
    location: location
    tagValues: tagValues
    firewallIP: firewall.outputs.firewallPrivateIP
    routeTableName: vmRouteTableName
    vmSubnetAddressPrefix: managementSubnetAddressPrefix
  }
}*/

module vm './modules/vm/vm.bicep' = {
  name: 'vm'
  scope: managementRG
  params: {
    location: location
    tagValues: tagValues
    managementSubnetID: vnet.outputs.managementSubnetID
    vmName: vmName
    vmSize: vmSize
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module recoveryServiceVault './modules/recoveryServiceVault/recoveryServiceVault.bicep' = {
  name: 'recoveryServiceVault'
  scope: backupRG
  params: {
    location: location
    tagValues: tagValues
    vaultName: recoveryServiceVaultName
  }
}

module managedIdentity './modules/managedIdentity/managedIdentity.bicep' = {
  name: 'managedIdentity'
  scope: networkRG
  params: {
    location: location
    tagValues: tagValues
    managedIdentityName: managedIdentityName
  }
}

module keyVault './modules/keyVault/keyVault.bicep' = {
  name: 'keyVault'
  scope: networkRG
  params: {
    location: location
    tagValues: tagValues
    keyVaultName: keyVaultName
    keyVaultSKU: keyVaultSKU
    objectID: managedIdentity.outputs.managedIdentityPrincipalID
  }
}

