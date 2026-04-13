module ApplicationHelper
  def nav_link(name, path, icon: nil)
    is_active = request.path.start_with?(path) && (path != admin_root_path || request.path == admin_root_path)

    base_classes = "group flex items-center px-2 py-2 text-sm font-medium rounded-md w-full "
    
    if is_active
      active_classes = "bg-gray-800 text-white border-l-4 border-yellow-500"
      css_classes = base_classes + active_classes
    else
      inactive_classes = "text-gray-300 hover:bg-gray-700 hover:text-white border-l-4 border-transparent"
      css_classes = base_classes + inactive_classes
    end

    link_to(path, class: css_classes) do
      name
    end
  end
end
