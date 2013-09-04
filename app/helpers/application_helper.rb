module ApplicationHelper
  def will_paginate_bootstrap(objects)
    will_paginate objects, :renderer => BootstrapPagination::Rails, :bootstrap => 3
  end
end
