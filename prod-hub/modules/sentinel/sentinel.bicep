

resource sentinel 'Microsoft.Security/sentinel@2021-01-01-preview' = {
  name: sentinelName
  location: location
  tags: tagValues
}
