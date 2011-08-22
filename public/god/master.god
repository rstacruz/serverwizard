God.load "/etc/god/conf.d/*.god"

God::Contacts::Email.message_settings = {
    :from => 'god@domain.org'
}

God::Contacts::Email.server_settings = {
    :address => "localhost",
    :port => 25,
    :domain => "domain.org",
}

God.contact(:email) do |c|
  c.name = 'ops'
  c.email = 'ops@domain.org'
end
