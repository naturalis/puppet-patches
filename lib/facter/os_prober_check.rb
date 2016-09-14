Facter.add(:osprober_isthere) do
  setcode do
    if File.exists?('/etc/grub.d/30_os-prober')
       'there'
    else
       'not there'
    end
  end
end
