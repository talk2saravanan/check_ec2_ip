#!/usr/bin/perl
################################################################################# 
# 21/10/2013 Saran -> talk2saravanan@yahoo.co.in
# 
#check_ec2_ip.pl -> check if given ip exist in given security group of Amazon Ec2 instance
################################################################################# 

use strict;
use warnings;

sub help {

		
	print <<EOF;
	
	Please install "VM::EC2" for the first time.
	$>cpanm install "VM::EC2";

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

	e.g >perl check_ec2_ip.pl --access_key="AKIAIFTWUCTKHN32JOEA" 
							  --secret_key="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" 
							  --security_group_name=default_saran2
							  --region=us-east-1
							  --ip_address=192.168.1.0

EOF
exit;
}

use VM::EC2;
use Data::Dumper;
use Getopt::Long;

#Inherited class
use IPEC2;
sub printd ;

my ($access_key,$secret_key,$security_group_name,$region,$ip,$debug,$help);
GetOptions(
    'access_key=s' => \$access_key,
	'secret_key=s' => \$secret_key,
	'security_group_name=s' => \$security_group_name,
	'ip_address=s' => \$ip,
	'region=s' => \$region,
	'debug!' => \$debug,
    'help!'     => \$help
) or die "Incorrect usage!\n".help();

die "Please provide access_key as a command line argument".help() unless($access_key);
die "Please provide secret_key as a command line argument".help() unless($secret_key);
die "Please provide security_group_name as a command line argument".help() unless($security_group_name);
die "Please provide region as a command line argument".help() unless($region);
die "Please provide ip_address as a command line argument".help() unless($ip);

help() if($help);

my $ipec2 = IPEC2->new(-access_key => $access_key,
                        -secret_key => $secret_key,
						-region     => $region,
						) or die "Cant connect to Ec2:$!\n";


if($ipec2->check_group($security_group_name)) {
	print "Group $security_group_name is available:SUCCESS\n";
}
else {
	print "Group $security_group_name is not available:FAILURE\n";
	my @available_groups = $ipec2->get_all_group_names;
	local $" = "\n";
	printd "Available Groups: \n@available_groups \n";
	exit;
}


if($ip=~/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/ &&(($1<=255  && $2<=255 && $3<=255  &&$4<=255 )))
{
	if($ipec2->find_ip($ip) ) {
		print "IP $ip is available:SUCCESS\n";
	}
	else {
		print "IP $ip is not available:FAILURE\n";
	}
}
else {
     print "Please provide valid ip address : $ip \n";
	 exit;
}

sub printd {
    
        print "@_"."\n" if ($debug);
}

