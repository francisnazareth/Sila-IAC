using './main.bicep'

param backupRGName = 'rg-backup-sila-hub-qc-01'
param managementRGName = 'rg-management-sila-hub-qc-01'
param monitoringRGName = 'rg-monitoring-sila-hub-qc-01'
param networkRGName = 'rg-network-sila-hub-qc-01'
param vnetAddressPrefix = '192.168.52.0/22'

param fgExtSubnetAddressPrefix = '192.168.52.0/27'
param fgIntSubnetAddressPrefix = '192.168.52.32/27'
param fgMgmtSubnetAddressPrefix = '192.168.52.64/27'
param fgHASubnetAddressPrefix = '192.168.52.96/27'

param paExtSubnetAddressPrefix = '192.168.52.128/27'
param paIntSubnetAddressPrefix = '192.168.52.160/27'
param paMgmtSubnetAddressPrefix = '192.168.52.192/27'
param paHASubnetAddressPrefix = '192.168.52.224/27'

param f5ExtSubnetAddressPrefix = '192.168.53.0/27'
param f5IntSubnetAddressPrefix = '192.168.53.32/27'
param f5MgmtSubnetAddressPrefix = '192.168.53.64/27'
param f5HASubnetAddressPrefix = '192.168.53.96/27'


param bastionSubnetAddressPrefix = '192.168.53.128/26'
param peSubnetAddressPrefix = '192.168.53.192/28'
param sharedServicesSubnetAddressPrefix = '192.168.53.208/28'
param managementSubnetAddressPrefix = '192.168.53.224/27'
param adSubnetAddressPrefix = '192.168.54.0/27'

param vnetName = 'vnet-sila-hub-qc-01'
param bastionName  = 'bastion-sila-hub-qc-01'
param bastionPublicIPName  = 'publicip-bastion-sila-hub-qc-01'
param bastionSku  = 'Premium'
param peSubnetName = 'snet-pe-hub-qc-01'
param managementSubnetName = 'snet-management-hub-qc-01'
param sharedServicesSubnetName = 'snet-sharedservices-hub-qc-01'
param logAnalyticsRetentionInDays  = 60
param logAnalyticsWorkspaceName  = 'law-sila-hub-qc-01'
param logAnalyticsSku = 'PerGB2018'
param ddosProtectionPlanName = 'ddosplan-sila-hub-qc-01'
param ddosProtectionPlanEnabled = true
param recoveryServiceVaultName = 'vault-sila-hub-qc-01'
param managedIdentityName = 'mi-kvaccess-sila-hub-qc-01'
param keyVaultName = 'kv-sila-hub-qc-001'
param keyVaultSKU = 'premium'
param vmName = 'silawinvm'
param vmSize = 'Standard_D2s_v3'
param vmNSGName = 'nsg-jumpserver-sila-hub-qc-01'
param adminUsername = 'adminuser'
param adminPassword = 'P@ssw0rd123!'
/*param vmRouteTableName = 'rt-jumpserver-sila-hub-qc-01'*/

param availabilityZones = [1,2,3]

param tagValues = {
    Environment: 'Hub'
    CostCenter: 'IT'
    Project: 'Sila Hub'
    CreatedBy: 'bicep'
    CreationDate: '2024-03-OCT'
}
