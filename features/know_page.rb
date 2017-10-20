# Persist knowledge of users
module KnowPageHelper
  def page_with_title(title, menu_id)
    FactoryGirl
      .create(
        :page,
        title: title,
        menu_title: title,
        menu_id: menu_id
      )
  end
end

World(KnowPageHelper)
