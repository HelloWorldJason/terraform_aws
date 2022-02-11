provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "this" {
    ami = "ami-01aa83ab14b00e516"         #在AWS上每个区域的AMI都不同，需要根据所在区域查看想要的AMI
    instance_type = "t2.micro"            #实例类型可根据自己业务环境进行选择，t1/2.micro是免费的
    key_name = aws_key_pair.ssh.key_name  #key_name是aws_instance中的一个参数，是指实例配置配置秘钥登录配置初始化主机。 
}

#添加ssh秘钥
resource "aws_key_pair" "ssh" {
    key_name = "jason"        #安全组中key的名字
    public_key = "xxxooookkkkG6GJ7oii0HwOwk46vlF0V4XT1RIdXwd6+vc63RE1xBmnJFiJibgwEmK9iBSxEw8yeC0o5JkzWofHjXyVePmfz5VWAHgLWxZ+CYDzjEvan37UDfVIQgREs5nHx57u7wH2MmwXZWoZTWgsXGuL16Zy5Bxv1AYj6bLFwdNtdhIXFWg+FikgeayjvEeXYNcX491Wyj2O33pYFQMOT7lzeARreMfb6mwWZbxBqFH6VoJdCzJnqq5viweZbYfWnjI21LKFvdelzuUm4WI5zN168OZR8i4pNWvfi0U/8ivqEACTVPPqXdpFxU4waIaYLvdX3y9/uLz9uaOPbyNbKlTE= test@facedns.com"
}

#开放22端口
resource "aws_security_group_rule" "ssh" {
    type = "ingress"    #ingress是入站，出站是egress
    from_port = 22      #启始端口
    to_port = 22        #结束端口
    protocol = "tcp"    #连接协议tcp/udp/http/all
    cidr_blocks = ["0.0.0.0/0"]   #允许访问的网段
    security_group_id = "sg-0a62ffb12ae1"   #默认AWS的default安全组，ressource创建的主机默认都会加入该组下。可以通过控制台查看
}
