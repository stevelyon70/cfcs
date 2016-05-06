<cfcomponent>

<cffunction name="html5" description="sets the doctype to HTML5" output="Yes" access="public"><!DOCTYPE html><html lang="en"></cffunction>

<cffunction name="mobile" description="sets the doctype to Mobile" output="Yes" access="public"><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd"></cffunction>

<cffunction name="transitional" description="sets the doctype to HTML4/Transitional" output="Yes" access="public"><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
</cffunction>

<cffunction name="loose" description="sets the doctype to HTML/Loose" output="Yes" access="public"><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
</cffunction>

<cffunction name="strict" description="sets the doctype to HTML/Strict" output="Yes" access="public"><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
</cffunction>

</cfcomponent>