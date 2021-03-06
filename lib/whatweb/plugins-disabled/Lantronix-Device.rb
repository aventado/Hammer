##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
Plugin.define "Lantronix-Device" do
author "Brendan Coles <bcoles@gmail.com>" # 2011-06-02
version "0.1"
description "Lantronix provides device networking and remote access products for remote IT management allowing remote computer access and offsite device control. Manage industrial control systems, or administer your entire data center using KVM over IP switches. - Homepage: http://www.lantronix.com/"

# ShodanHQ results as at 2011-06-02 #
# 823 for Gordian Embedded



# Matches #
matches [

# Version Detection # /summary.html
{ :url=>"/summary.html", :version=>/<TITLE>Lantronix ThinWeb Manager ([\d\.]+): Home<\/TITLE>/ },

# Version Detection # /navigation.html
{ :url=>"/navigation.html", :version=>/<img src="logo\.gif" width=129 height=84 border=0 alt="Lantronix ThinWeb Manager ([\d\.]+)"><br>/ },

# Model Detection # /navigation.html
{ :url=>"/navigation.html", :model=>/<font face="Arial,Helvetica" color="#660066"><b>([^<]+)<\/b><\/font><br><br>/ },

]

# Passive #
def passive
	m=[]

	# HTTP Server Header
	if @headers["server"] =~ /^Gordian Embedded([\d\.]+)$/

		# Version Detection
		m << { :version=>@headers["server"].scan(/^Gordian Embedded([\d\.]+)$/) }

		# Model Detection
		m << { :model=>@body.scan(/<font face="Arial,Helvetica" color="#660066"><b>([^<]+)<\/b><\/font><br><br>/) } if @body =~ /<font face="Arial,Helvetica" color="#660066"><b>([^<]+)<\/b><\/font><br><br>/

	end

	# Return passive matches
	m
end

end

