provider "aws" {
    region = var.region  #通过variables文件获取信息
}

resource "aws_instance" "this" {
    ami = lookup(var.amis, var.region)    #这里可能难理解，为什么括号中两个值，那是以为lookup的内容是一个map类型,map中需要查看region的key中的values值  
    instance_type = var.instance_type            
    key_name = aws_key_pair.ssh.key_name  #key_name是aws_instance中的一个参数，是指实例配置配置秘钥登录配置初始化主机。 
    user_data = file("set_nginx.sh")      #读取同级别目录下的文件

    tags = {   # tags主要在EC2中的tag进行加一个tags标签主要在控制台实例中name字段，方便查看读取维护.
        Name = "Nginx-web-server" 
    }
}



#添加ssh秘钥
resource "aws_key_pair" "ssh" {
    key_name = "jason"        #安全组中key的名字
    public_key = file(var.public_key)
}

#开放22端口
resource "aws_security_group_rule" "ssh" {
    type = "ingress"    #ingress是入站，出站是egress
    from_port = 22      #启始端口
    to_port = 22        #结束端口
    protocol = "tcp"    #连接协议tcp/udp/http/all
    cidr_blocks = ["0.0.0.0/0"]   #允许访问的网段
    security_group_id =  var.security_group
}

#开放80端口
resource "aws_security_group_rule" "web" {
    type = "ingress"    #ingress是入站，出站是egress
    from_port = 80      #启始端口
    to_port = 80        #结束端口
    protocol = "tcp"    #连接协议tcp/udp/http/all
    cidr_blocks = ["0.0.0.0/0"]   #允许访问的网段
    security_group_id =  var.security_group
}
