Name: smart-kiosk
Version: 1
Release: 0
Summary: Smart kiosk management scripts
Source0: smart-kiosk-1.tar.gz
License: GPL
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-buildroot
%description
Smart kiosk management scripts
%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/etc/smart-kiosk
install -m 0755 -d $RPM_BUILD_ROOT/usr/bin/
install -m 0644 etc/smart-kiosk/smart-kiosk.conf $RPM_BUILD_ROOT/etc/smart-kiosk/smart-kiosk.conf

install -m 0755 usr/bin/smart-kiosk-dhcpd.sh $RPM_BUILD_ROOT/usr/bin/smart-kiosk-dhcpd.sh
install -m 0755 usr/bin/smart-kiosk-mac-correcter.sh $RPM_BUILD_ROOT/usr/bin/smart-kiosk-mac-correcter.sh
install -m 0755 usr/bin/smart-kiosk-named.sh $RPM_BUILD_ROOT/usr/bin/smart-kiosk-named.sh
install -m 0755 usr/bin/smart-kiosk-shell.sh $RPM_BUILD_ROOT/usr/bin/smart-kiosk-shell.sh




%clean
rm -rf $RPM_BUILD_ROOT
%post
echo Smart Kiosk management scripts successfully installed!
echo vim /etc/smart-kiosk/smart-kiosk.conf
%files
%dir /etc/smart-kiosk
/etc/smart-kiosk/smart-kiosk.conf
/usr/bin/smart-kiosk-dhcpd.sh
/usr/bin/smart-kiosk-mac-correcter.sh
/usr/bin/smart-kiosk-named.sh
/usr/bin/smart-kiosk-shell.sh

