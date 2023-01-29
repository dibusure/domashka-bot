require 'selenium-webdriver'
require 'json'
require 'telegram/bot'



#disable gui
options = Selenium::WebDriver::Firefox::Options.new
options.add_argument '--headless'
driver = Selenium::WebDriver.for :firefox, options: options

#open url and take login
driver.get 'https://school.mosreg.ru/userfeed'
file = File.read("./cookies.json")
data = JSON.parse(file)

driver.manage.add_cookie(name: "SchoolMosregAuth_a", value: data['SchoolMosregAuth_a'])
driver.manage.add_cookie(name: "SchoolMosregAuth_l", value: data['SchoolMosregAuth_l']) 
driver.navigate.refresh

driver.find_element(:class, "BJvVR").click
p "-- ", driver.find_element(:class, "_3tdXB").text

s = driver.find_element(:class, "_3tdXB").text

#check weekend
if s["суббота"]
  driver.find_element(:class, "BJvVR").click
  driver.find_element(:class, "BJvVR").click
elsif s["воскресенье"] 
  driver.find_element(:class, "BJvVR").click
else
  p "-- normal day, good luck"
end

sleep(1)
#take work and classes
classes = driver.find_elements(:class, "_201cJ")
work = driver.find_elements(:class, "_2j_JP")
date = driver.find_element(:class, "_3tdXB")


a = {}
classes.zip(work).each do |el|
  a[el[0].text]=el[1].text
end

p a

#write result to file
File.open("./result.json","w") do |f|
  a["date"] = date.text
  f.write(JSON.pretty_generate(a))
end

# thanks to 3Jl0y_PYCCKUi and Franzusskaya schlucha
