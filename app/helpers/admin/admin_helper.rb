module Admin::AdminHelper

  def kingsnake_categories
    [
      ['Adoptions','adoptions'],
      ['Ball Pythons','ball_pythons'],
      ['Pythons','pythons'],
      ['Tree boas','tree_boas'],
      ['Boa constrictors','boa_constrictors'],
      ['Other boas','other_boas'],
      ['Rose, rubber, and sand boas','rose_rubber_and_sand_boas'],
      ['New world rat snakes','new_world_rat_snakes'],
      ['Old world rat snakes','old_world_rat_snakes'],
      ['Corn snakes','corn_snakes'],
      ['Gray-banded kingsnakes','gray_banded_kingsnakes'],
      ['Other kings and milksnakes','other_kings_and_milksnakes'],
      ['Other snakes','other_snakes'],
      ['Venomous','venomous']
    ].freeze
  end

  def navigation
    links = logged_in? ? [
      link_to('Categories', admin_categories_path),
      link_to('Products', admin_products_path),
      link_to('Caresheets', admin_caresheets_path),
      link_to('Announcements', admin_announcements_path),
      link_to('Post-O-Matic', admin_post_o_matic_postings_path),
      link_to("Log out", logout_path)
    ] : []
    links.join(' | ')
  end
end
