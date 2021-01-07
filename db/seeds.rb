image_urls = [
  'https://www.theactionpixel.com/wp-content/uploads/2019/06/ww84_banner.jpg',
  'https://www.dccomics.com/sites/default/files/imce/2019/12-DEC/WW84_VERT_Wonder_Woman_Character_Art_DOM_2764x4096_master_5ded728e04c472.84919392.jpg',
  'https://www.filmstories.co.uk/wp-content/uploads/2020/03/Wonder-Woman-1984.jpg',
  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.PHTMg8t_C81H0UZ_RyFo0gHaJQ%26pid%3DApi&f=1',
  'https://pursuenews.com/wp-content/uploads/2020/05/rev-1-WW84-04683r_High_Res_JPEG-scaled.jpeg',

  'https://fanart.tv/fanart/movies/300668/moviebackground/annihilation-5ac7a147b78ab.jpg',
  'http://cdn.collider.com/wp-content/uploads/2018/01/annihilation-poster.jpg',
  'http://culturalhater.com/wp-content/uploads/2018/07/Annihilation-review-cultural-hater.jpg',
  'https://www.newdvdreleasedates.com/images/posters/large/annihilation-2018-02.jpg',
  'https://www.slashfilm.com/wp/wp-content/images/annihilation-trailer.jpg',

  'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.lynchburgparksandrec.com%2Fwp-content%2Fuploads%2F2016%2F01%2Fcamaje-cooking-7.jpg&f=1&nofb=1',
  'http://i.huffpost.com/gen/3227146/images/o-HOME-COOKING-facebook.jpg',
  'http://listdose.co/wp-content/uploads/2013/06/cooking.jpg',
  'http://notablelife.com/media/2015/07/cooking-class.jpg',
  'https://a57.foxnews.com/a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2019/01/640/320/1862/1048/salmon-cooking-istock.jpg?ve=1&tl=1?ve=1&tl=1',

  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmamasgeeky.com%2Fwp-content%2Fuploads%2F2020%2F12%2Fdeath-to-2020-poster.jpg&f=1&nofb=1',
  'https://www.thedad.com/wp-content/uploads/2020/12/20201.jpg',
  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIF.qgXnHYBi8uiFZn%252bqXFM2bw%26pid%3DApi&f=1',
  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.unilad.co.uk%2Fwp-content%2Fuploads%2F2020%2F12%2Fdeathto2020NETFLIX.jpg&f=1&nofb=1',
  'https://www.hitc.com/static/uploads/2020/12/Screen-Shot-2020-12-29-at-15.39.12-1024x683.png'
]

image_urls.each do |url|
  Image.create!(url: url)
end
