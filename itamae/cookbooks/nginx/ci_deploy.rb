group "httpcontent" do
  gid 2000
end

group "droneio" do
  gid 2001
end

directory "/srv/http" do
  owner "root"
  group "httpcontent"
  mode "775"
end

user "droneio" do
  uid 2001
  gid "httpcontent"
  home "/home/droneio"
end

directory "/home/droneio/.ssh" do
  owner "droneio"
  group "droneio"
  mode "0700"
end

file "/home/droneio/.ssh/authorized_keys" do
  authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+WvfkClLF+nGPiPNSBQoVMFiFruIG3Wt9PuN/DTAf1d4Is0fYWMwbULOkzNkmO3r6HabLTxEgX0mG310ywJmI1WfXapQaJ6zpfrO/dV6fVAMTNiQaYiJKp3py5r77IMFKsu/bqIOl5xZHTIp6rgDxndptK0pgdUszdkJ5griE812cNon+oO67tIdcwBhDBl0RRvKcRGkrqEZr5mWbfEPNSts92h2S7CIBnNN4tt8tqbWxTjDLW72dPu2Aj0ALZlbF4/q+Qay/6Ug31Y98EWlsauGF+RWbdrE0rc9+AO/kYvtKw2rZD5Eyn+EDkzxSJOe7duAtiYIt4NkobxYh3tz5"]

  content authorized_keys.join(?\n) + ?\n
  owner "droneio"
  group "droneio"
  mode "600"
end
