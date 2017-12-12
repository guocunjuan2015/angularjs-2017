package com.rqb.common.mapper;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParser.Feature;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.fasterxml.jackson.module.jaxb.JaxbAnnotationModule;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;


public class JsonMapper extends ObjectMapper
{
  private static final long serialVersionUID = 1L;
  private static Logger logger = Logger.getLogger(JsonMapper.class);
  private static JsonMapper mapper;

  public JsonMapper()
  {
    this(JsonInclude.Include.NON_EMPTY);
  }

  public JsonMapper(JsonInclude.Include include)
  {
    if (include != null) {
      setSerializationInclusion(include);
    }

    enableSimple();

    disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

    getSerializerProvider().setNullValueSerializer(new JsonSerializer()
    {
      public void serialize(Object value, JsonGenerator jgen, SerializerProvider provider)
        throws IOException, JsonProcessingException
      {
        jgen.writeString("");
      }
    });
  }

  public static JsonMapper getInstance()
  {
    if (mapper == null) {
      mapper = new JsonMapper().enableSimple();
    }
    return mapper;
  }

  public static JsonMapper nonDefaultMapper()
  {
    if (mapper == null) {
      mapper = new JsonMapper(JsonInclude.Include.NON_DEFAULT);
    }
    return mapper;
  }

  public String toJson(Object object)
  {
    try
    {
      return writeValueAsString(object);
    } catch (IOException e) {
      logger.warn("write to json string error:" + object, e);
    }return null;
  }

  public <T> T fromJson(String jsonString, Class<T> clazz)
  {
    if (StringUtils.isEmpty(jsonString))
      return null;
    try
    {
      return readValue(jsonString, clazz);
    } catch (IOException e) {
      logger.warn("parse json string error:" + jsonString, e);
    }return null;
  }

  public <T> T fromJson(String jsonString, JavaType javaType)
  {
    if (StringUtils.isEmpty(jsonString))
      return null;
    try
    {
      return readValue(jsonString, javaType);
    } catch (IOException e) {
      logger.warn("parse json string error:" + jsonString, e);
    }return null;
  }

  public JavaType createCollectionType(Class<?> collectionClass, Class<?>[] elementClasses)
  {
    return getTypeFactory().constructParametricType(collectionClass, elementClasses);
  }

  public <T> T update(String jsonString, T object)
  {
    try
    {
      return readerForUpdating(object).readValue(jsonString);
    } catch (JsonProcessingException e) {
      logger.warn("update json string:" + jsonString + " to object:" + object + " error.", e);
    } catch (IOException e) {
      logger.warn("update json string:" + jsonString + " to object:" + object + " error.", e);
    }
    return null;
  }

  public String toJsonP(String functionName, Object object)
  {
    return toJson(new JSONPObject(functionName, object));
  }

  public JsonMapper enableEnumUseToString()
  {
    enable(SerializationFeature.WRITE_ENUMS_USING_TO_STRING);
    enable(DeserializationFeature.READ_ENUMS_USING_TO_STRING);
    return this;
  }

  public JsonMapper enableJaxbAnnotation()
  {
    JaxbAnnotationModule module = new JaxbAnnotationModule();
    registerModule(module);
    return this;
  }

  public JsonMapper enableSimple()
  {
    configure(Feature.ALLOW_SINGLE_QUOTES, true);
    configure(Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
    return this;
  }

  public ObjectMapper getMapper()
  {
    return this;
  }

  public static String toJsonString(Object object)
  {
    return getInstance().toJson(object);
  }

  public static void main(String[] args)
  {
    List list = new ArrayList();
    Map map = new HashMap();
    map.put("id", Integer.valueOf(1));
    map.put("pId", Integer.valueOf(-1));
    map.put("name", "根节点");
    list.add(map);
    map = new HashMap();
    map.put("id", Integer.valueOf(2));
    map.put("pId", Integer.valueOf(1));
    map.put("name", "你好");
    map.put("open", Boolean.valueOf(true));
    list.add(map);
    String json = getInstance().toJson(list);
    System.out.println(json);
  }
}