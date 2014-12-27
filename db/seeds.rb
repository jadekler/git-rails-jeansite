projects = Project.create([
        {title: 'Boom Projecto', github_url: 'http://boom.com'},
        {title: 'Yolo swaggins', github_url: 'http://boom.com'},
        {title: 'Boom Amigos', github_url: 'http://boom.com'},
        {title: 'Several Projects', github_url: 'http://boom.com'},
        {title: 'Heyo Projecto', github_url: 'http://boom.com'},
        {title: 'Bam Project', github_url: 'http://boom.com'}
])

@blogs = []

Dir[File.dirname(__FILE__) + '/blogs/*.rb'].each do |file|
    require file
end

blogs = @blogs
