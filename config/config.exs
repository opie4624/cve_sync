# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
import Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :cve_sync, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:cve_sync, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

config :cve_sync, env: config_env()

config :tesla, adapter: Tesla.Adapter.Mint
config :tesla, Tesla.Adapter.Mint, body_as: :stream
config :mnesia, dir: ~c".mnesia/#{config_env()}/#{node()}"

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{config_env()}.exs"
