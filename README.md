# jenkins-ldap

## LDIF服务器配置
+ 不能使用明文密码，否则会导致ldap服务验证失败

```
rootpw {SSHA}FXqxTqroSVl0j8QUmm7igOD1e7Cu1mXm # slappasswd -s moobyee
```

+ 不能使用bdb数据库，切换到ldif才能在MAC下正常密码验证

```
database ldif
```

## Jenkins账号系统接入配置

+ root DN: dc=next,dc=com
+ Manager DN: cn=Manager,dc=next,dc=com
+ Manager Password: moobyee
