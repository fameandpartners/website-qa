class FortyFourPage < MainBasePage

  h1(:hQuestionTitle,text:'Looking for something?')
  h2(:hSorryTitle,xpath:"//h2[contains(text(),'this page doesn')]")

  paragraph(:prgTryPrg, xpath:"//p[contains(text(),'Try our')]")
  link(:lnkHomePage,xpath:"//a[text()='homepage']/../a[@href='/']")

  paragraph(:prgEmailUsPrg, xpath:"//p[contains(text(),'find what you')]")
  link(:lnkEmailUs,xpath:"//a[@href='mailto:team@fameandpartners.com']/../a[text()='E-mail us']")


end