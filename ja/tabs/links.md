---
layout: links
# multilingual page pair id, this must pair with translations of this page. (This name must be unique)
lng_pair: id_links
permalink: "/ja/links/"

# publish date (used for seo)
# if not specified, site.time will be used.
#date: 2022-03-03 12:32:00 +0000

# for override items in _data/lang/[language].yml
#title: My title
#button_name: "My button"
# for override side_and_top_nav_buttons in _data/conf/main.yml
#icon: "fa fa-bath"

# seo
# if not specified, date will be used.
#meta_modify_date: 2022-03-03 12:32:00 +0000
# check the meta_common_description in _data/owner/[language].yml
#meta_description: ""

# optional
# please use the "image_viewer_on" below to enable image viewer for individual pages or posts (_posts/ or [language]/_posts folders).
# image viewer can be enabled or disabled for all posts using the "image_viewer_posts: true" setting in _data/conf/main.yml.
#image_viewer_on: true
# please use the "image_lazy_loader_on" below to enable image lazy loader for individual pages or posts (_posts/ or [language]/_posts folders).
# image lazy loader can be enabled or disabled for all posts using the "image_lazy_loader_posts: true" setting in _data/conf/main.yml.
#image_lazy_loader_on: true
# exclude from on site search
#on_site_search_exclude: true
# exclude from search engines
#search_engine_exclude: true
# to disable this page, simply set published: false or delete this file
#published: false


# you can always move this content to _data/content/ folder
# just create new file at _data/content/links/[language].yml and move content below.
###########################################################
#                Links Page Data
###########################################################
page_data:
  main:
    header: "Links"
    info: "Various things that I find interesting or worth sharing."

  # To change order of the Categories, simply change order. (you don't need to change list order.)
  category:
    - title: "Frameworks"
      type: frameworks
      color: "#8da9ef"
    - title: "Japanese"
      type: japanese
      color: "#f93437"
    - title: "Books"
      type: books
      color: "#c4adf7"

  list:
    -
    # frameworks
    - type: frameworks
      title: "Quasar"
      url: "https://quasar.dev/"
      info: "Quasar is a VueJS based, write-once-compile-everywhere development framework for creating modern web applications. It supports compiling to mobile and desktop environments."
    - type: frameworks
      title: "Ruby on Rails"
      url: "https://rubyonrails.org/"
      info: "A Ruby framework for developing modern web applications."

    # Japanese
    - type: japanese
      title: "Learn Japanese"
      url: "https://www.tofugu.com/learn-japanese/"
      info: "A pretty thorough guide for adult native English speakers to learn Japanese."
    - type: japanese
      title: "Learn Hiragana"
      url: "https://www.tofugu.com/japanese/learn-hiragana/"
      info: "Hiragana is essentially the Japanese alphabet, and one of the first things you should learn when picking up Japanese."
    - type: japanese
      title: "Learn Katakana"
      url: "https://www.tofugu.com/japanese/learn-katakana/"
      info: "Katakana is fairly 1:1 with Hiragana, but is primarily used for transcribing foreign words, and for writing foreign loan words such as ホテル (Hotel)."
    - type: japanese
      title: "Jisho"
      url: "https://jisho.org/"
      info: "One of the most powerful, and useful, English-Japanese dictionaries out there. Absolutely indispensable while learning Japanese."
    - type: japanese
      title: "WaniKani"
      url: "https://www.wanikani.com/"
      info: "An online tool for learning Kanji via a spaced-repetition system. Essentially flashcards with some extra magic to help take advantage of memory formation quirks."

    # Books
    - type: books
      title: "Getting Things Done, David Allen"
      url: "https://smile.amazon.com/dp/B00KWG9M2E/"
      info: "A productivity book on how to stay sane in a modern world and all its new distractions. Origin of the 'GTD' methodology."
    - type: books
      title: "The Life-Changing Magic of Tidying Up, Marie Kondō"
      url: "https://smile.amazon.com/dp/B00KK0PICK/"
      info: "A book on how to declutter your home and life, to great effect. Commonly referred to as the 'KonMari method'."
    - type: books
      title: "1984, George Orwell"
      url: "https://smile.amazon.com/dp/B003JTHWKU/"
      info: "A hauntingly accurate view of the dangers stemming from the control and flow of information, ideas, and language. World famous, and an absolute must read."
---
