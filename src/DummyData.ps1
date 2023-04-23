        $pwds = @([pscustomobject] @{
            ComputerName = "test-pc"
            Password = "MySmallTestPassword#"
            PasswordUpdateTime = [datetime]::Now
            ExpirationTimestamp = [datetime]::Now
        })
        $pwds += [pscustomobject] @{
            ComputerName = "test-pc"
            Password = "MyHistoryTestPasswordWithManyCharacters#"
            PasswordUpdateTime = [datetime]::Parse("22.04.2023 10:40:56")
            ExpirationTimestamp = $null
        }
        $pwds += [pscustomobject] @{
            ComputerName = "test-pc"
            Password = "MyHistoryTestPassword#"
            PasswordUpdateTime = [datetime]::Parse("23.03.2023 10:10:23")
            ExpirationTimestamp = $null
        }