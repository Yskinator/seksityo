module ApplicationHelper
  def stat_sort_link(column, title = nil)
    # Uses helper methods from AdminsController.

    # If title is nil, make title from the column name
    title ||= column.titleize


    # Adds css classes "current" and "asd"/"desc", if column is currently being used to sort.
    # If the column is not being used to sort currently, add no classes.
    css_class = column == stat_sort_column ? "current #{stat_sort_direction}" : nil

    # If the direction is set to ascending, switch to descending. Default to ascending.
    # Only if the column is currently being used to sort.
    direction = column == stat_sort_column && stat_sort_direction == "asc" ? "desc" : "asc"

    # Return link logic to view, adds hash of parameters to the url, adds css classes
    link_to title, {:stat_sort => column, :stat_direction => direction}, {:class => css_class}
  end

  def meeting_sort_link(column, title = nil)
    # Uses helper methods from AdminsController.

    # If title is nil, make title from the column name
    title ||= column.titleize


    # Adds css classes "current" and "asd"/"desc", if column is currently being used to sort.
    # If the column is not being used to sort currently, add no classes.
    css_class = column == meeting_sort_column ? "current #{meeting_sort_direction}" : nil

    # If the direction is set to ascending, switch to descending. Default to ascending.
    # Only if the column is currently being used to sort.
    direction = column == meeting_sort_column && meeting_sort_direction == "asc" ? "desc" : "asc"

    # Return link logic to view, adds hash of parameters to the url, adds css classes
    link_to title, {:meeting_sort => column, :meeting_direction => direction}, {:class => css_class}
  end


end
