check_ec2_ip
===============
Requirement:
------------
A script that matches the given ip address from all rules of a security group for EC2 . For example I have a security group called "database-servers" that have many rules. We want all rules if it has the  source "100.100.100.100" .  Assume the user will be running it on the command line.

STEPS TO FOLLOW:

1)	Please install "VM::EC2" for the first time.
	$>perl -MCPAN -e "install VM::EC2"

	Reference : http://search.cpan.org/~lds/VM-EC2-1.23/lib/VM/EC2/SecurityGroup.pm

2)Create Amazon AWS account . Note down your access_key , secret_key,region,security_group_name,etc

3) Note the ip address you want to find

4)sync the git repository --> https://github.com/talk2saravanan/check_ec2_ip

5)Do Compilation check 
$>perl -wc check_ec2_ip.pl
check_ec2_ip.pl syntax OK


6) Use command line help
    perl check_ec2_ip.pl --help

        Please install "VM::EC2" for the first time.
        $>perl -MCPAN -e "install VM::EC2"

        Reference : http://search.cpan.org/~lds/VM-EC2-1.23/lib/VM/EC2/SecurityGroup.pm


        HELP

	perl check_ec2_ip.pl [OPTIONS]
	Options:
	access_key				Access Key for Amazon Ec2 Instance
	secret_key				Secret Key
	security_group_name		specify security group name
	region					region
	ip_address				ip_address to check if it exists
	debug					Optional.Enable debug mode
	help					Optional.Print help information.

        e.g >perl check_ec2_ip.pl  --access_key="AKIAIFTWUCTKHN32JOEA"
                                         --secret_key="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"
                                         --security_group_name=default_saran2
                                         --region=us-east-1
                                         --ip_address=192.168.1.5



7)Execute the command by passing your access_key,secret_key,
$>perl check_ec2_ip.pl --access_key="AKIAIFTWUCTKHN32JOEA" --secret_
key="bfZ0fS0vrcg1i6dORTJ8uEasdxtXVxbAMkWD3Qj0" --security_group_name=default_sar
an2 -region=us-east-1 --ip_address=192.168.1.0 

8) Check the Output
    It is expected to get output something like this
	
Group default_saran2 is available:SUCCESS
IP 192.168.1.0 is available:SUCCESS

9) Else enable debug mode
$>perl check_ec2_ip.pl --access_key="AKIAIFTWUCTKHN32JOEA" --secret_
key="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" --security_group_name=default_sara2
 -region=us-east-1 --ip_address=192.168.1.0 --debug
Group default_sara2 is not available:FAILURE
Available Groups:
 {default}_test2
default_test7
{default_test7}_5
default
default_saran2
{default}_2
default_test3
{default}_test7
{default}_5
{default}_1
default_test2
{default}_test
{default}_test8
default_saran2_saran2
{default}_test1
default_test
{default}_test9
{default}_3
default_saran1
default
Test

10) I have tested it in live 

