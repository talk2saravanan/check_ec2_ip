check_ec2_ip
===============


  ***Please install "VM::EC2" for the first time.***
	   $>perl -MCPAN -e "install VM::EC2"
	   
	   During installation.There will be a prompt to enter "access_key" and "secret_key".
	   Please press enter to skip it.

	Reference : http://search.cpan.org/~lds/VM-EC2-1.23/lib/VM/EC2/SecurityGroup.pm

	
	e.g >perl check_ec2_ip.pl  --access_key="AKIAIFTWUCTKHN32JOEA" 
							  --secret_key="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" 
							  --security_group_name=default_saran2
							  --region=us-east-1
							  --ip_address=192.188.2.1/24


D:\saran\perl>perl check_ec2_ip.pl --help

        	Please install "VM::EC2" for the first time.
	        $>perl -MCPAN -e "install VM::EC2"



        Reference : http://search.cpan.org/~lds/VM-EC2-1.23/lib/VM/EC2/SecurityGroup.pm

	HELP 
	perl check_ec2_ip.pl [OPTIONS]
	Options:
	access_key				Access Key for Amazon Ec2 Instance
	secret_key				Secret Key
	security_group_name			specify security group name
	region					region
	ip_address				ip_address to check if it exists
	debug					Optional.Enable debug mode
	help					Optional.Print help information.


        e.g >perl check_ec2_ip.pl  --access_key="AKIAIFTWUCTKHN32JOEA"
                                         --secret_key="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"
                                         --security_group_name=default_saran2
                                         --region=us-east-1
                                         --ip_address=192.168.1.5



$>perl check_ec2_ip.pl --access_key="AKIAIFTWUCTKHN32JOEA" --secret_
key="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" --security_group_name=default_sar
an2 -region=us-east-1 --ip_address=192.168.1.0 
Group default_saran2 is available:SUCCESS
IP 192.168.1.0 is available:SUCCESS

Debug mode

D:\saran\perl>perl check_ec2_ip.pl --access_key="AKIAIFTWUCTKHN32JOEA" --secret_
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

