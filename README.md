# statsd-builder

Vagrant VM that builds a statsd debian package.

You may want to edit STATSD_VERSION in Vagrantfile.

## Known issues

The published version of the statsd cookbook breaks because it tries to install
the generated deb using the wrong version/filename. Since provisioning then
stops, you need to copy the deb file from /tmp to /vagrant manually.
