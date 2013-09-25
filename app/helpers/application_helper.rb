module ApplicationHelper
  def will_paginate_bootstrap(objects, options={})
    will_paginate objects, {:renderer => BootstrapPagination::Rails, :bootstrap => 3}.merge(options)
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    target.active_model_serializer.new(target, options).to_json
  end
end
