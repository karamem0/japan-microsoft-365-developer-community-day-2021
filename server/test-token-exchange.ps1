param (
    [Parameter(ValueFromPipeline = $true)]
    [string]$Token
)

Invoke-RestMethod `
    -Uri "https://localhost:5001/auth/token" `
    -Method "Post" `
    -Headers @{ Authorization = "Bearer $Token"; "Content-Type" = "application/json" } `
    -Body (ConvertTo-Json @{ scope = "User.Read"; grant_type = "sso_token" }) `
    | Format-List
