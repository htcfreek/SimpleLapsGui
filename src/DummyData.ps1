    $pwds = @([pscustomobject] @{
        ComputerName = "test-pc"
        Password = "MySmallTestPassword#"
        PasswordUpdateTime = [datetime]::Now
        ExpirationTimestamp = [datetime]::Now
    })
    $pwds += [pscustomobject] @{
        ComputerName = "test-pc"
        Password = "MyHistoryTestPasswordWithManyCharacters#"
        PasswordUpdateTime = [datetime]::Parse("22.04.2026 10:40:56")
        ExpirationTimestamp = $null
    }
    $pwds += [pscustomobject] @{
        ComputerName = "test-pc"
        Password = "MyHistoryTestPassword#"
        PasswordUpdateTime = [datetime]::Parse("23.03.2025 10:10:23")
        ExpirationTimestamp = $null
    }
    $pwds += @([pscustomobject] @{
        ComputerName = "test-pc"
        Password = $null
        PasswordUpdateTime = [datetime]::Parse("23.03.2000 10:10:23")
        ExpirationTimestamp = $null
    })