#!/usr/bin/perl
################################################################################# 
# 21/10/2013 Saran -> talk2saravanan@yahoo.co.in
# 
#IPEC2 -> Module to check if the given security group and IP exists in ec2 instance.
#Supporting functions
#check_group() --> check if given group exist in the ec2 region
#get_all_group_names() --> Display all group names in the given ec2 region
# find_ip() -> Find if the given ip exist
################################################################################# 

use strict;
use warnings;

package IPEC2;

my $default_access_key = 'AKIAIFTWUCTKHN32JOEA';
my $default_secret_key = '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';
my $default_security_group_name = 'default';
my $default_region = 'us-east-1';

my $default_endpoint = 'http://ec2.amazonaws.com';

#------------------------------------------------------------------------- 
#new() --> Constructor.Instantiates object which contains Ec2 object
#------------------------------------------------------------------------- 
sub new {

	my $self = shift;
	my %args = @_;

	my $href->{ec2_object} = VM::EC2->new(-access_key => $args{-access_key} || $default_access_key,
							    -secret_key => $args{-secret_key} || $default_secret_key,
							    -endpoint   => $args{-endpoint} || $default_endpoint,
								-region     => $args{-region} || $default_region
								) or return(0);

	my $obj = bless $href,ref $self || $self;

	return($obj);
}

#------------------------------------------------------------------------- 
#check_group() --> check if given group exist in the ec2 region
#------------------------------------------------------------------------- 
sub check_group {

	my $self = shift;
	my($security_group_name) = @_;

	my $ec2 = $self->{ec2_object};
	
	
	my @all_groupnames =  $self->get_all_group_names();

	if(scalar(@all_groupnames) == 0) {
		return(0);
	}

	foreach my $group_name (@all_groupnames) {
		if($group_name =~/$security_group_name/si) {
			$self->{-security_group_name} = $security_group_name;
			return(1);
		}
	}

	return(0);
}

#------------------------------------------------------------------------- 
#get_all_group_names() --> Display all group names in the given ec2 region
#------------------------------------------------------------------------- 
sub get_all_group_names {

	my $self = shift;
	my $ec2 = $self->{ec2_object};
	
	my @all_sg =  $ec2->describe_security_groups();
	
	my @all_groupnames;
	foreach my $sg (@all_sg) {
		my $group_name = $sg->groupName;
		push(@all_groupnames,$group_name);
	}

	return(@all_groupnames);
}

#------------------------------------------------------------------------- 
# find_ip() -> Find if the given ip exist
#------------------------------------------------------------------------- 
sub find_ip {
	
	my $self = shift;
	my ($ip) = @_;

	my $security_group_name = $self->{-security_group_name};
	my $ec2 = $self->{ec2_object};
	my $sg = $ec2->describe_security_groups(-name=>$security_group_name) or die $ec2->error_str."Group name $security_group_name not found.Invalid Group Name : $!\n";

	my @rules = $sg->ipPermissions;
	my $found = 0;
	
	if(scalar(@rules) == 0) {
		return(0);
	}
	  
	foreach my $rule (@rules) {
		my @ranges = $rule->ipRanges;
		if(scalar(@ranges) eq 0) {
			next;
		}
		foreach my $range (@ranges) {
			my $ip_rx = qr/$ip/;
			if($range =~/$ip_rx/gi) {
				return(1);
			}
		}
	}	
	

	return($found);
}

1;
