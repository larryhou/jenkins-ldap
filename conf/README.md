#####LDIF服务器配置
+ 不能使用明文密码，否则会导致ldap服务验证失败
	
  > rootpw {SSHA}aKymjoeU6I6qy6+UGJROi51mM9YMaFvs
+ 不能使用bdb数据库，切换到ldif才能在MAC下正常密码验证
	
  > database	ldif

#####Jenkins账号系统接入配置

+ root DN: dc=next,dc=com
+ Manager DN: cn=Manager,dc=next,dc=com
+ Manager Password: 870404