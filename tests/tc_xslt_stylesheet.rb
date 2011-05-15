# $Id: tc_xslt_stylesheet.rb,v 1.1.1.1 2004/01/05 07:38:25 xpovolny Exp $

class TC_XSLT_STYLESHEET < Test::Unit::TestCase
  def set_up()
    @xslt = XML::XSLT.file('tests/fuzface.xsl')
    @xslt.doc = XML::Document.file('tests/fuzface.xml')
    assert_instance_of(XML::XSLT, @xslt)
    assert_instance_of(XML::Document, @xslt.doc)
    @stylesheet = @xslt.parse
    assert_instance_of(XML::XSLT::Stylesheet, @stylesheet)
  end
  
  def tear_down()
    @xslt = nil
    @stylesheet = nil
  end
  
  def test_ruby_xslt_parse()
    assert_instance_of(XML::XSLT::Stylesheet, @stylesheet)
  end

  def test_ruby_xslt_stylesheet_to_s()
    @stylesheet.apply
    str = @stylesheet.to_s
    assert_instance_of(String, str)
  end

  def test_ruby_xslt_stylesheet_save()
    assert_raises(ArgumentError) do
      @stylesheet.save("str")
    end
  end
end
