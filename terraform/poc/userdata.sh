#!/bin/bash
# Basic user-data to install nginx and render a page with environment details
set -euo pipefail

# Update packages
dnf -y update || true

# Install nginx
dnf -y install nginx

# Start and enable nginx
systemctl enable nginx
systemctl start nginx

# Metadata & simple app page
INSTANCE_ID="$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone || echo "unknown")
DB_ENDPOINT="${db_endpoint}"

cat > /usr/share/nginx/html/index.html << 'HTML'
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>AWS Retail POC</title>
    <style>
      body { font-family: system-ui, Arial, sans-serif; margin: 2rem; }
      code { background: #f6f8fa; padding: 0.2rem 0.4rem; border-radius: 4px; }
      .card { border: 1px solid #eee; padding: 1rem 1.5rem; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
    </style>
  </head>
  <body>
    <h1>🚀 AWS Retail POC</h1>
    <p>This server is behind an <strong>Application Load Balancer</strong> and running in a private subnet.</p>
    <div class="card">
      <h3>Instance Details</h3>
      <ul>
        <li>Instance ID: <code id="iid"></code></li>
        <li>Availability Zone: <code id="az"></code></li>
        <li>DB Endpoint (from Terraform output): <code id="db"></code></li>
      </ul>
    </div>
    <script>
      document.getElementById('iid').textContent = 'REPLACED_INSTANCE_ID';
      document.getElementById('az').textContent = 'REPLACED_AZ';
      document.getElementById('db').textContent = 'REPLACED_DB_ENDPOINT';
    </script>
  </body>
</html>
HTML

sed -i "s/REPLACED_INSTANCE_ID/$INSTANCE_ID/" /usr/share/nginx/html/index.html
sed -i "s/REPLACED_AZ/$AZ/" /usr/share/nginx/html/index.html
sed -i "s|REPLACED_DB_ENDPOINT|$DB_ENDPOINT|" /usr/share/nginx/html/index.html
