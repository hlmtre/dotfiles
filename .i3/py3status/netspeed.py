from time import time
from subprocess import check_output
class Py3status:
  def kill(self, i3status_output_json, i3status_config):
    pass

  def on_click(self, i3status_output_json, i3status_config, event):
    pass

  def netspeed(self, i3status_output_json, i3status_config):
    if not self._isup('enp0s25'):
      text = ""
    else:
      text = self._get_network_bytes('enp0s25')
    response = {'cached_until': time(), 'full_text': text, 'name': 'netspeed', 'instance': 'first'}
    return (0, response)

  def _isup(self, interface):
    f = check_output(('ip link show ' + interface).split())
    if 'state UP' in f:
      return True
    return False

  def _get_network_bytes(self, interface):
    for line in open('/proc/net/dev', 'r'):
      if interface in line:
        data = line.split('%s:' % interface)[1].split()
        rx_bytes, tx_bytes = (data[0], data[8])
        try:
          f = open('/tmp/netspeedenp0s25', 'r+')
        except IOError:
          f = open('/tmp/netspeedenp0s25', 'w+')
        line = f.readline()
        prev_rx = 0
        prev_tx = 0
        if line != "":
          prev_rx = line.split()[0]
          prev_tx = line.split()[1]
          f.seek(0)
          f.write(str(rx_bytes) + " " + str(tx_bytes) + "\n")
        else:
          f.seek(0)
          f.write(str(rx_bytes) + " " + str(tx_bytes) + "\n")

# if we assume this is being updated every second... it becomes bytes per second.
        if prev_rx == 0 or prev_tx == 0:
          return interface + ": " +  str(int(rx_bytes) / 1024) + "v|^" + str(int(tx_bytes) / 1024) + " kB/s"
        return interface + ": " + str((int(rx_bytes) - int(prev_rx)) / 1024) + "v|^" + str((int(tx_bytes) - int(prev_tx)) / 1024) + " kB/s"
