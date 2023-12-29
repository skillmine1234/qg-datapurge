require "qg/datapurge/engine"

module Qg
  module Datapurge
    NAME = 'Datapurge'
    GROUP = 'datapurge'
    MENU_ITEMS = []
    MODELS = ['PgrRequest']
    TEST_MENU_ITEMS = []
    COMMON_MENU_ITEMS = [:purge_request,:purge_analytics]
  end
end

