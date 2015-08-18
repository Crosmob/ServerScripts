MODULE="pcspkr";

if lsmod | grep "$MODULE" &> /dev/null ; then
  echo "$MODULE is loaded!"
  rmmod pcspkr;
fi

echo "Hostname: $(hostname)";
echo -n "$(hostname) ip:"; /sbin/ifconfig | sed -n '2 p' | awk '{print $2}'

