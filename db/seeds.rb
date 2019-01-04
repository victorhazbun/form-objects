user = User.create(name: "El macho")
user.social_networks.create([
  {
    url: 'ga.com'
  }, 
  {
    url: 'ge.com'
  },
  {
    url: 'gi.com'
  },
  {
    url: 'go.com'
  },
  {
    url: 'gu.com'
  },
])