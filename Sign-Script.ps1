# ============================================================== 
#   Script: Sign-Script.ps1
#   Name: Sign-Script
#   Written By: Ben Felton
#   Version 1.0
#   Description: Sign and Verify Powershell Scripts
#   Requires: User must have vaild CodeSigning certificate
# ============================================================== 

param
(
    [parameter(Mandatory=$true, HelpMessage="You must specify a Script to Sign or Verify")] [string] $Script,
    [Parameter(Mandatory=$false)] [switch] $Verify,
    [Parameter(Mandatory=$false)] [switch] $Sign
)

Function Sign-Script
{
    param
    (  
        [parameter(Mandatory = $true)] [string] $FilePath  
    ) 

    $Cert = Get-SigningCert
    Set-AuthenticodeSignature -Certificate $Cert -FilePath $FilePath
}

Function Verify-Script
{
    param
    (  
        [parameter(Mandatory = $true)] [string] $FilePath  
    ) 

    $Signature = (Get-AuthenticodeSignature -FilePath $FilePath)
    Write-Host ("Signature Type: " + $Signature.SignatureType)
    Write-Host ("Status: " + $Signature.Status)
    Write-Host ("Status Details: " + $Signature.StatusMessage)
    Write-Host ("Certificate Thumprint: " + $Signature.SignerCertificate.Thumbprint)
    
}

Function Get-SigningCert
{
    $Cert = @(Get-ChildItem cert:\CurrentUser\My -CodeSigning)[0]
    Return $Cert
}


If ($Verify)
{
    Verify-Script $Script
}
Elseif ($Sign)
{
    Sign-Script $Script
}
Else 
{
    Write-Error "You Must Specify an Action (-Sign or -Verify)"
}
# SIG # Begin signature block
# MIIIbgYJKoZIhvcNAQcCoIIIXzCCCFsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUXD6xjzdPC8uLmcbTL85LT6uP
# uymgggXWMIIF0jCCBLqgAwIBAgITQQAAAAfGbW0qQCNC3QAAAAAABzANBgkqhkiG
# 9w0BAQsFADBKMRIwEAYKCZImiZPyLGQBGRYCbWUxFzAVBgoJkiaJk/IsZAEZFgdm
# ZWx0b25zMRswGQYDVQQDExJGZWx0b25zLk1lIFJvb3QgQ0EwHhcNMjAwOTIzMDIz
# OTMwWhcNMjUwOTIyMDIzOTMwWjBrMRIwEAYKCZImiZPyLGQBGRYCbWUxFzAVBgoJ
# kiaJk/IsZAEZFgdmZWx0b25zMRYwFAYDVQQLDA1GZWx0b25zX1VzZXJzMQ8wDQYD
# VQQLEwZBZHVsdHMxEzARBgNVBAMTCkJlbiBGZWx0b24wggEiMA0GCSqGSIb3DQEB
# AQUAA4IBDwAwggEKAoIBAQCUcJUpo1B+IV7XmsGXRuhiM21ANYlyCYb6MafdGoL9
# u6iEejgoWBg1nc9XPXQ0b0q9mxW9dae6elSR4v6RJ3/cukU5OWv9cwS+tg6Vk+xM
# pvCGjP62gSoU4ALLGsi1y/2EjjPcGQ8QdYVDxfDtaWjk7Mw4jlIDePPT4nD2yjme
# j2IwLTgIvPATz/ujVWhmFIVX31j6haz8Vs3GIy8/XJaafhb7Cuf3w7yt7xtvGIbX
# WipJ95H84r4JawVHyzMv+Mfycf5rMa9iug9wz5AyfHiXUpSpe9/l70GsKA1Ovvxa
# esJWEMlPzgzTGYdUnw3XoBzwtHILgyWhlBgQY0QzKAzxAgMBAAGjggKOMIICijA8
# BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQimv3mE4ch/hK2PM4S8vVSGlYUBE4aA
# p16G7M5LAgFkAgEHMBMGA1UdJQQMMAoGCCsGAQUFBwMDMA4GA1UdDwEB/wQEAwIG
# wDAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBT65NYBlKZp
# OLVuSMqVPpDxtSuL3zAfBgNVHSMEGDAWgBTq742pWF/vYbOwytRAnxhyvm4WDzCB
# 0gYDVR0fBIHKMIHHMIHEoIHBoIG+hoG7bGRhcDovLy9DTj1GZWx0b25zLk1lJTIw
# Um9vdCUyMENBLENOPVNFUlZFUixDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
# dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1mZWx0b25zLERD
# PW1lP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1j
# UkxEaXN0cmlidXRpb25Qb2ludDCBxwYIKwYBBQUHAQEEgbowgbcwgbQGCCsGAQUF
# BzAChoGnbGRhcDovLy9DTj1GZWx0b25zLk1lJTIwUm9vdCUyMENBLENOPUFJQSxD
# Tj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1
# cmF0aW9uLERDPWZlbHRvbnMsREM9bWU/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
# dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwKQYDVR0RBCIwIKAeBgorBgEE
# AYI3FAIDoBAMDmJlbkBmZWx0b25zLm1lMA0GCSqGSIb3DQEBCwUAA4IBAQADtfCi
# ZIBhyV3AH1vESuATmL0fvueigupTTsn71ddAalxwn34ESceBUR0fNv2GyGbS0aou
# qf8sO3FE4w5lTGyXC6Y9bVH+o2/toqjxHU78H3t7kGSWSFflAtJ+WGdpHCvTBl8J
# abGgK+ddNtOyes4j96RQnjCnepShiXPnD3bWx3uCg3HzPhe/EFG4YHWv6+2fzaC/
# pTbmO5MXB2Ewihniurtsr8vsSlNlnet8gpZy8fPfeO11LgoE79wH2HVqUQ1xlPei
# meduvpglPHOfM8Ywq+AfMdD7eAcZHWw3qfluzfQNMTkGyM2qcjcyFbS1NWm10mBC
# 1tAkw+Yl4V8Mf8mMMYICAjCCAf4CAQEwYTBKMRIwEAYKCZImiZPyLGQBGRYCbWUx
# FzAVBgoJkiaJk/IsZAEZFgdmZWx0b25zMRswGQYDVQQDExJGZWx0b25zLk1lIFJv
# b3QgQ0ECE0EAAAAHxm1tKkAjQt0AAAAAAAcwCQYFKw4DAhoFAKB4MBgGCisGAQQB
# gjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYK
# KwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFL9dUS4k
# 36N7IB8y7MoHma4OTtU3MA0GCSqGSIb3DQEBAQUABIIBAH/LkDBDcC5kTmbw95mS
# g2ir90DgqHak5tBKMw4yPzaJgBsUE1Q9treD8m+zME7o3pCaz63IQ6pKxGF0p/Nm
# 0SdMV0FiQbivRikqwYjuxAF4EBZqv9oSAvbNDluFipuQGQUhdAk+WUOO1Pq4OfNe
# BpuourPe3PhGcoq26o86Hl1RKnFjUvxBzospi4qLqFxkMoXdslE1KWGe8KrxMhSA
# kGldwEAkNnHnIiieEV1bATqClXgfMALEpbwmXmhiA4lydZAPgJQuQ0INLNLdUDfh
# cJJujcIDZc78C5UIBYz3rjwwF3UEryhPO7I3gvJzfD/4g6BSIp5QQ0tJ6ERLTreV
# OCg=
# SIG # End signature block
