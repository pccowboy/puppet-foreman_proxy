class foreman_proxy::tftp {
  include ::tftp

  file{ $foreman_proxy::params::tftp_dir:
    ensure  => directory,
    owner   => $foreman_proxy::params::user,
    mode    => '0644',
    require => Class['foreman_proxy::install'],
    recurse => true;
  }

  foreman_proxy::tftp::sync_file{ ['pxelinux.0','menu.c32','chain.c32']:
    source_path => ${foreman_proxy::params::syslinux_root},
    target_path => $foreman_proxy::params::tftproot,
    require     => Class['tftp::install'];
  }
}
