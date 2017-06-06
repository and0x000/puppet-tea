# Type to match base32 String
type Tea::Base32 = Pattern[/^[a-z2-7]+={,6}$/, /^[A-Z2-7]+={,6}$/]
