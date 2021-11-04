Import-PfxCertificate -Password (ConvertTo-SecureString -String "jpm365dcd2021" -AsPlainText -Force) -CertStoreLocation "cert:\CurrentUser\Root" -FilePath "$PSScriptRoot/cert/localhost.pfx"
