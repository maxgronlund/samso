# Persist knowledge of users
module KnowPageHelper
  def page_with_title(title)
    FactoryGirl
      .create(
        :page,
        title: title,
        menu_title: title,
        menu_id: 'menu_bar'
      )
  end
end

World(KnowPageHelper)
