package com.solar.tech.dbutil;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.json.JSONException;
import org.json.JSONObject;

import com.solar.tech.bean.Attribute;

public class JSONUtil {
	
	/**
	 * 将json字符串转换成  javaBean  javaBean的  属性都需要时装箱的  目前只处理了Integer String  Boolean
	 * @param clazz
	 * @param str
	 * @return
	 */
	public static <T> T toObject(Class<T> clazz,String str){
		T obj=null;
		try {
			obj=clazz.newInstance();
			JSONObject jsonObj=new JSONObject(str);
			Method[] methods=clazz.getMethods();
			for(Method method:methods){
				String methodName=method.getName();
				if(methodName.startsWith("set")){
					String key=methodName.substring(3);
					key=key.substring(0, 1).toLowerCase()+key.substring(1);
					if(jsonObj.has(key)){
						Class<?> paramType=method.getParameterTypes()[0];
						//参数是Integer
						if(paramType.equals(Integer.class)){
							if(jsonObj.get(key) instanceof String)
								method.invoke(obj, Integer.valueOf(jsonObj.get(key).toString()));
							if(jsonObj.get(key) instanceof Boolean){
								boolean bValue=jsonObj.getBoolean(key);
								if(bValue==true)
									method.invoke(obj, 1);
								else
									method.invoke(obj, 0);
							}
							if(jsonObj.get(key) instanceof Integer)
								method.invoke(obj,jsonObj.get(key));
						}
						//参数String
						if(paramType.equals(String.class))
							method.invoke(obj, jsonObj.get(key).toString());
						//参数Bool
						if(paramType.equals(Boolean.class)){
							if(jsonObj.get(key) instanceof String){
								if("true".equals(jsonObj.getString(key)))
									method.invoke(obj, true);
								else
									method.invoke(obj, false);
							}
							if(jsonObj.get(key) instanceof Boolean){
								method.invoke(obj,jsonObj.get(key));
							}
							if(jsonObj.get(key) instanceof Integer){
								int bValue=jsonObj.getInt(key);
								if(bValue==0)
									method.invoke(obj, false);
								else
									method.invoke(obj, true);
							}
						}
					}
				}
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	
	/**
	 * 将json对象  javaBean  javaBean的  属性都需要时装箱的  目前只处理了Integer String  Boolean
	 * @param clazz
	 * @param jsonObj
	 * @return
	 */
	public static <T> T toObject(Class<T> clazz,JSONObject jsonObj){
		T obj=null;
		try {
			obj=clazz.newInstance();
			Method[] methods=clazz.getMethods();
			for(Method method:methods){
				String methodName=method.getName();
				if(methodName.startsWith("set")){
					String key=methodName.substring(3);
					key=key.substring(0, 1).toLowerCase()+key.substring(1);
					if(jsonObj.has(key)){
						Class<?> paramType=method.getParameterTypes()[0];
						//参数是Integer
						if(paramType.equals(Integer.class)){
							if(jsonObj.get(key) instanceof String){
								String s=jsonObj.get(key).toString();
								s="".equals(s)?"0":s;
								method.invoke(obj, Integer.valueOf(s));
							}
								
							if(jsonObj.get(key) instanceof Boolean){
								boolean bValue=jsonObj.getBoolean(key);
								if(bValue==true)
									method.invoke(obj, 1);
								else
									method.invoke(obj, 0);
							}
							if(jsonObj.get(key) instanceof Integer)
								method.invoke(obj,jsonObj.get(key));
						}
						//参数String
						if(paramType.equals(String.class))
							method.invoke(obj, jsonObj.get(key).toString());
						//参数Bool
						if(paramType.equals(Boolean.class)){
							if(jsonObj.get(key) instanceof String){
								if("true".equals(jsonObj.getString(key)))
									method.invoke(obj, true);
								else
									method.invoke(obj, false);
							}
							if(jsonObj.get(key) instanceof Boolean){
								method.invoke(obj,jsonObj.get(key));
							}
							if(jsonObj.get(key) instanceof Integer){
								int bValue=jsonObj.getInt(key);
								if(bValue==0)
									method.invoke(obj, false);
								else
									method.invoke(obj, true);
							}
						}
					}
				}
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	public static void main(String[] args) {
		String str="{\"attributeCName\":\"1\",\"attributeEName\":\"1\",\"isPrimariKey\":true,\"isAllowNull\":false,\"isIndex\":false,\"isUnique\":false,\"length\":\"1\",\"type\":\"1\",\"validataRuler\":\"1\"}";
		toObject(Attribute.class,str);
//		System.out.println(toObject(Attribute.class,str));
	}
	
}
