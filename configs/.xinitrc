# Virtualbox guest services
VBoxClient-all

# Load .Xresources if present
[[ -f .Xresources ]] && xrdb -load .Xresources

exec i3
