module glad.gl.ext;

private import glad.gl.types;

private import glad.gl.enums;

private import glad.gl.funcs;

bool GL_3DFX_multisample;
bool GL_3DFX_tbuffer;
bool GL_3DFX_texture_compression_FXT1;
bool GL_AMD_blend_minmax_factor;
bool GL_AMD_conservative_depth;
bool GL_AMD_debug_output;
bool GL_AMD_depth_clamp_separate;
bool GL_AMD_draw_buffers_blend;
bool GL_AMD_gcn_shader;
bool GL_AMD_gpu_shader_int64;
bool GL_AMD_interleaved_elements;
bool GL_AMD_multi_draw_indirect;
bool GL_AMD_name_gen_delete;
bool GL_AMD_occlusion_query_event;
bool GL_AMD_performance_monitor;
bool GL_AMD_pinned_memory;
bool GL_AMD_query_buffer_object;
bool GL_AMD_sample_positions;
bool GL_AMD_seamless_cubemap_per_texture;
bool GL_AMD_shader_atomic_counter_ops;
bool GL_AMD_shader_stencil_export;
bool GL_AMD_shader_trinary_minmax;
bool GL_AMD_sparse_texture;
bool GL_AMD_stencil_operation_extended;
bool GL_AMD_texture_texture4;
bool GL_AMD_transform_feedback3_lines_triangles;
bool GL_AMD_transform_feedback4;
bool GL_AMD_vertex_shader_layer;
bool GL_AMD_vertex_shader_tessellator;
bool GL_AMD_vertex_shader_viewport_index;
bool GL_APPLE_aux_depth_stencil;
bool GL_APPLE_client_storage;
bool GL_APPLE_element_array;
bool GL_APPLE_fence;
bool GL_APPLE_float_pixels;
bool GL_APPLE_flush_buffer_range;
bool GL_APPLE_object_purgeable;
bool GL_APPLE_rgb_422;
bool GL_APPLE_row_bytes;
bool GL_APPLE_specular_vector;
bool GL_APPLE_texture_range;
bool GL_APPLE_transform_hint;
bool GL_APPLE_vertex_array_object;
bool GL_APPLE_vertex_array_range;
bool GL_APPLE_vertex_program_evaluators;
bool GL_APPLE_ycbcr_422;
bool GL_ARB_ES2_compatibility;
bool GL_ARB_ES3_1_compatibility;
bool GL_ARB_ES3_2_compatibility;
bool GL_ARB_ES3_compatibility;
bool GL_ARB_arrays_of_arrays;
bool GL_ARB_base_instance;
bool GL_ARB_bindless_texture;
bool GL_ARB_blend_func_extended;
bool GL_ARB_buffer_storage;
bool GL_ARB_cl_event;
bool GL_ARB_clear_buffer_object;
bool GL_ARB_clear_texture;
bool GL_ARB_clip_control;
bool GL_ARB_color_buffer_float;
bool GL_ARB_compatibility;
bool GL_ARB_compressed_texture_pixel_storage;
bool GL_ARB_compute_shader;
bool GL_ARB_compute_variable_group_size;
bool GL_ARB_conditional_render_inverted;
bool GL_ARB_conservative_depth;
bool GL_ARB_copy_buffer;
bool GL_ARB_copy_image;
bool GL_ARB_cull_distance;
bool GL_ARB_debug_output;
bool GL_ARB_depth_buffer_float;
bool GL_ARB_depth_clamp;
bool GL_ARB_depth_texture;
bool GL_ARB_derivative_control;
bool GL_ARB_direct_state_access;
bool GL_ARB_draw_buffers;
bool GL_ARB_draw_buffers_blend;
bool GL_ARB_draw_elements_base_vertex;
bool GL_ARB_draw_indirect;
bool GL_ARB_draw_instanced;
bool GL_ARB_enhanced_layouts;
bool GL_ARB_explicit_attrib_location;
bool GL_ARB_explicit_uniform_location;
bool GL_ARB_fragment_coord_conventions;
bool GL_ARB_fragment_layer_viewport;
bool GL_ARB_fragment_program;
bool GL_ARB_fragment_program_shadow;
bool GL_ARB_fragment_shader;
bool GL_ARB_fragment_shader_interlock;
bool GL_ARB_framebuffer_no_attachments;
bool GL_ARB_framebuffer_object;
bool GL_ARB_framebuffer_sRGB;
bool GL_ARB_geometry_shader4;
bool GL_ARB_get_program_binary;
bool GL_ARB_get_texture_sub_image;
bool GL_ARB_gpu_shader5;
bool GL_ARB_gpu_shader_fp64;
bool GL_ARB_gpu_shader_int64;
bool GL_ARB_half_float_pixel;
bool GL_ARB_half_float_vertex;
bool GL_ARB_imaging;
bool GL_ARB_indirect_parameters;
bool GL_ARB_instanced_arrays;
bool GL_ARB_internalformat_query;
bool GL_ARB_internalformat_query2;
bool GL_ARB_invalidate_subdata;
bool GL_ARB_map_buffer_alignment;
bool GL_ARB_map_buffer_range;
bool GL_ARB_matrix_palette;
bool GL_ARB_multi_bind;
bool GL_ARB_multi_draw_indirect;
bool GL_ARB_multisample;
bool GL_ARB_multitexture;
bool GL_ARB_occlusion_query;
bool GL_ARB_occlusion_query2;
bool GL_ARB_parallel_shader_compile;
bool GL_ARB_pipeline_statistics_query;
bool GL_ARB_pixel_buffer_object;
bool GL_ARB_point_parameters;
bool GL_ARB_point_sprite;
bool GL_ARB_post_depth_coverage;
bool GL_ARB_program_interface_query;
bool GL_ARB_provoking_vertex;
bool GL_ARB_query_buffer_object;
bool GL_ARB_robust_buffer_access_behavior;
bool GL_ARB_robustness;
bool GL_ARB_robustness_isolation;
bool GL_ARB_sample_locations;
bool GL_ARB_sample_shading;
bool GL_ARB_sampler_objects;
bool GL_ARB_seamless_cube_map;
bool GL_ARB_seamless_cubemap_per_texture;
bool GL_ARB_separate_shader_objects;
bool GL_ARB_shader_atomic_counter_ops;
bool GL_ARB_shader_atomic_counters;
bool GL_ARB_shader_ballot;
bool GL_ARB_shader_bit_encoding;
bool GL_ARB_shader_clock;
bool GL_ARB_shader_draw_parameters;
bool GL_ARB_shader_group_vote;
bool GL_ARB_shader_image_load_store;
bool GL_ARB_shader_image_size;
bool GL_ARB_shader_objects;
bool GL_ARB_shader_precision;
bool GL_ARB_shader_stencil_export;
bool GL_ARB_shader_storage_buffer_object;
bool GL_ARB_shader_subroutine;
bool GL_ARB_shader_texture_image_samples;
bool GL_ARB_shader_texture_lod;
bool GL_ARB_shader_viewport_layer_array;
bool GL_ARB_shading_language_100;
bool GL_ARB_shading_language_420pack;
bool GL_ARB_shading_language_include;
bool GL_ARB_shading_language_packing;
bool GL_ARB_shadow;
bool GL_ARB_shadow_ambient;
bool GL_ARB_sparse_buffer;
bool GL_ARB_sparse_texture;
bool GL_ARB_sparse_texture2;
bool GL_ARB_sparse_texture_clamp;
bool GL_ARB_stencil_texturing;
bool GL_ARB_sync;
bool GL_ARB_tessellation_shader;
bool GL_ARB_texture_barrier;
bool GL_ARB_texture_border_clamp;
bool GL_ARB_texture_buffer_object;
bool GL_ARB_texture_buffer_object_rgb32;
bool GL_ARB_texture_buffer_range;
bool GL_ARB_texture_compression;
bool GL_ARB_texture_compression_bptc;
bool GL_ARB_texture_compression_rgtc;
bool GL_ARB_texture_cube_map;
bool GL_ARB_texture_cube_map_array;
bool GL_ARB_texture_env_add;
bool GL_ARB_texture_env_combine;
bool GL_ARB_texture_env_crossbar;
bool GL_ARB_texture_env_dot3;
bool GL_ARB_texture_filter_minmax;
bool GL_ARB_texture_float;
bool GL_ARB_texture_gather;
bool GL_ARB_texture_mirror_clamp_to_edge;
bool GL_ARB_texture_mirrored_repeat;
bool GL_ARB_texture_multisample;
bool GL_ARB_texture_non_power_of_two;
bool GL_ARB_texture_query_levels;
bool GL_ARB_texture_query_lod;
bool GL_ARB_texture_rectangle;
bool GL_ARB_texture_rg;
bool GL_ARB_texture_rgb10_a2ui;
bool GL_ARB_texture_stencil8;
bool GL_ARB_texture_storage;
bool GL_ARB_texture_storage_multisample;
bool GL_ARB_texture_swizzle;
bool GL_ARB_texture_view;
bool GL_ARB_timer_query;
bool GL_ARB_transform_feedback2;
bool GL_ARB_transform_feedback3;
bool GL_ARB_transform_feedback_instanced;
bool GL_ARB_transform_feedback_overflow_query;
bool GL_ARB_transpose_matrix;
bool GL_ARB_uniform_buffer_object;
bool GL_ARB_vertex_array_bgra;
bool GL_ARB_vertex_array_object;
bool GL_ARB_vertex_attrib_64bit;
bool GL_ARB_vertex_attrib_binding;
bool GL_ARB_vertex_blend;
bool GL_ARB_vertex_buffer_object;
bool GL_ARB_vertex_program;
bool GL_ARB_vertex_shader;
bool GL_ARB_vertex_type_10f_11f_11f_rev;
bool GL_ARB_vertex_type_2_10_10_10_rev;
bool GL_ARB_viewport_array;
bool GL_ARB_window_pos;
bool GL_ATI_draw_buffers;
bool GL_ATI_element_array;
bool GL_ATI_envmap_bumpmap;
bool GL_ATI_fragment_shader;
bool GL_ATI_map_object_buffer;
bool GL_ATI_meminfo;
bool GL_ATI_pixel_format_float;
bool GL_ATI_pn_triangles;
bool GL_ATI_separate_stencil;
bool GL_ATI_text_fragment_shader;
bool GL_ATI_texture_env_combine3;
bool GL_ATI_texture_float;
bool GL_ATI_texture_mirror_once;
bool GL_ATI_vertex_array_object;
bool GL_ATI_vertex_attrib_array_object;
bool GL_ATI_vertex_streams;
bool GL_EXT_422_pixels;
bool GL_EXT_abgr;
bool GL_EXT_bgra;
bool GL_EXT_bindable_uniform;
bool GL_EXT_blend_color;
bool GL_EXT_blend_equation_separate;
bool GL_EXT_blend_func_separate;
bool GL_EXT_blend_logic_op;
bool GL_EXT_blend_minmax;
bool GL_EXT_blend_subtract;
bool GL_EXT_clip_volume_hint;
bool GL_EXT_cmyka;
bool GL_EXT_color_subtable;
bool GL_EXT_compiled_vertex_array;
bool GL_EXT_convolution;
bool GL_EXT_coordinate_frame;
bool GL_EXT_copy_texture;
bool GL_EXT_cull_vertex;
bool GL_EXT_debug_label;
bool GL_EXT_debug_marker;
bool GL_EXT_depth_bounds_test;
bool GL_EXT_direct_state_access;
bool GL_EXT_draw_buffers2;
bool GL_EXT_draw_instanced;
bool GL_EXT_draw_range_elements;
bool GL_EXT_fog_coord;
bool GL_EXT_framebuffer_blit;
bool GL_EXT_framebuffer_multisample;
bool GL_EXT_framebuffer_multisample_blit_scaled;
bool GL_EXT_framebuffer_object;
bool GL_EXT_framebuffer_sRGB;
bool GL_EXT_geometry_shader4;
bool GL_EXT_gpu_program_parameters;
bool GL_EXT_gpu_shader4;
bool GL_EXT_histogram;
bool GL_EXT_index_array_formats;
bool GL_EXT_index_func;
bool GL_EXT_index_material;
bool GL_EXT_index_texture;
bool GL_EXT_light_texture;
bool GL_EXT_misc_attribute;
bool GL_EXT_multi_draw_arrays;
bool GL_EXT_multisample;
bool GL_EXT_packed_depth_stencil;
bool GL_EXT_packed_float;
bool GL_EXT_packed_pixels;
bool GL_EXT_paletted_texture;
bool GL_EXT_pixel_buffer_object;
bool GL_EXT_pixel_transform;
bool GL_EXT_pixel_transform_color_table;
bool GL_EXT_point_parameters;
bool GL_EXT_polygon_offset;
bool GL_EXT_polygon_offset_clamp;
bool GL_EXT_post_depth_coverage;
bool GL_EXT_provoking_vertex;
bool GL_EXT_raster_multisample;
bool GL_EXT_rescale_normal;
bool GL_EXT_secondary_color;
bool GL_EXT_separate_shader_objects;
bool GL_EXT_separate_specular_color;
bool GL_EXT_shader_image_load_formatted;
bool GL_EXT_shader_image_load_store;
bool GL_EXT_shader_integer_mix;
bool GL_EXT_shadow_funcs;
bool GL_EXT_shared_texture_palette;
bool GL_EXT_sparse_texture2;
bool GL_EXT_stencil_clear_tag;
bool GL_EXT_stencil_two_side;
bool GL_EXT_stencil_wrap;
bool GL_EXT_subtexture;
bool GL_EXT_texture;
bool GL_EXT_texture3D;
bool GL_EXT_texture_array;
bool GL_EXT_texture_buffer_object;
bool GL_EXT_texture_compression_latc;
bool GL_EXT_texture_compression_rgtc;
bool GL_EXT_texture_compression_s3tc;
bool GL_EXT_texture_cube_map;
bool GL_EXT_texture_env_add;
bool GL_EXT_texture_env_combine;
bool GL_EXT_texture_env_dot3;
bool GL_EXT_texture_filter_anisotropic;
bool GL_EXT_texture_filter_minmax;
bool GL_EXT_texture_integer;
bool GL_EXT_texture_lod_bias;
bool GL_EXT_texture_mirror_clamp;
bool GL_EXT_texture_object;
bool GL_EXT_texture_perturb_normal;
bool GL_EXT_texture_sRGB;
bool GL_EXT_texture_sRGB_decode;
bool GL_EXT_texture_shared_exponent;
bool GL_EXT_texture_snorm;
bool GL_EXT_texture_swizzle;
bool GL_EXT_timer_query;
bool GL_EXT_transform_feedback;
bool GL_EXT_vertex_array;
bool GL_EXT_vertex_array_bgra;
bool GL_EXT_vertex_attrib_64bit;
bool GL_EXT_vertex_shader;
bool GL_EXT_vertex_weighting;
bool GL_EXT_x11_sync_object;
bool GL_GREMEDY_frame_terminator;
bool GL_GREMEDY_string_marker;
bool GL_HP_convolution_border_modes;
bool GL_HP_image_transform;
bool GL_HP_occlusion_test;
bool GL_HP_texture_lighting;
bool GL_IBM_cull_vertex;
bool GL_IBM_multimode_draw_arrays;
bool GL_IBM_rasterpos_clip;
bool GL_IBM_static_data;
bool GL_IBM_texture_mirrored_repeat;
bool GL_IBM_vertex_array_lists;
bool GL_INGR_blend_func_separate;
bool GL_INGR_color_clamp;
bool GL_INGR_interlace_read;
bool GL_INTEL_fragment_shader_ordering;
bool GL_INTEL_framebuffer_CMAA;
bool GL_INTEL_map_texture;
bool GL_INTEL_parallel_arrays;
bool GL_INTEL_performance_query;
bool GL_KHR_blend_equation_advanced;
bool GL_KHR_blend_equation_advanced_coherent;
bool GL_KHR_context_flush_control;
bool GL_KHR_debug;
bool GL_KHR_no_error;
bool GL_KHR_robust_buffer_access_behavior;
bool GL_KHR_robustness;
bool GL_KHR_texture_compression_astc_hdr;
bool GL_KHR_texture_compression_astc_ldr;
bool GL_KHR_texture_compression_astc_sliced_3d;
bool GL_MESAX_texture_stack;
bool GL_MESA_pack_invert;
bool GL_MESA_resize_buffers;
bool GL_MESA_window_pos;
bool GL_MESA_ycbcr_texture;
bool GL_NVX_conditional_render;
bool GL_NVX_gpu_memory_info;
bool GL_NV_bindless_multi_draw_indirect;
bool GL_NV_bindless_multi_draw_indirect_count;
bool GL_NV_bindless_texture;
bool GL_NV_blend_equation_advanced;
bool GL_NV_blend_equation_advanced_coherent;
bool GL_NV_blend_square;
bool GL_NV_command_list;
bool GL_NV_compute_program5;
bool GL_NV_conditional_render;
bool GL_NV_conservative_raster;
bool GL_NV_conservative_raster_dilate;
bool GL_NV_copy_depth_to_color;
bool GL_NV_copy_image;
bool GL_NV_deep_texture3D;
bool GL_NV_depth_buffer_float;
bool GL_NV_depth_clamp;
bool GL_NV_draw_texture;
bool GL_NV_evaluators;
bool GL_NV_explicit_multisample;
bool GL_NV_fence;
bool GL_NV_fill_rectangle;
bool GL_NV_float_buffer;
bool GL_NV_fog_distance;
bool GL_NV_fragment_coverage_to_color;
bool GL_NV_fragment_program;
bool GL_NV_fragment_program2;
bool GL_NV_fragment_program4;
bool GL_NV_fragment_program_option;
bool GL_NV_fragment_shader_interlock;
bool GL_NV_framebuffer_mixed_samples;
bool GL_NV_framebuffer_multisample_coverage;
bool GL_NV_geometry_program4;
bool GL_NV_geometry_shader4;
bool GL_NV_geometry_shader_passthrough;
bool GL_NV_gpu_program4;
bool GL_NV_gpu_program5;
bool GL_NV_gpu_program5_mem_extended;
bool GL_NV_gpu_shader5;
bool GL_NV_half_float;
bool GL_NV_internalformat_sample_query;
bool GL_NV_light_max_exponent;
bool GL_NV_multisample_coverage;
bool GL_NV_multisample_filter_hint;
bool GL_NV_occlusion_query;
bool GL_NV_packed_depth_stencil;
bool GL_NV_parameter_buffer_object;
bool GL_NV_parameter_buffer_object2;
bool GL_NV_path_rendering;
bool GL_NV_path_rendering_shared_edge;
bool GL_NV_pixel_data_range;
bool GL_NV_point_sprite;
bool GL_NV_present_video;
bool GL_NV_primitive_restart;
bool GL_NV_register_combiners;
bool GL_NV_register_combiners2;
bool GL_NV_sample_locations;
bool GL_NV_sample_mask_override_coverage;
bool GL_NV_shader_atomic_counters;
bool GL_NV_shader_atomic_float;
bool GL_NV_shader_atomic_fp16_vector;
bool GL_NV_shader_atomic_int64;
bool GL_NV_shader_buffer_load;
bool GL_NV_shader_buffer_store;
bool GL_NV_shader_storage_buffer_object;
bool GL_NV_shader_thread_group;
bool GL_NV_shader_thread_shuffle;
bool GL_NV_tessellation_program5;
bool GL_NV_texgen_emboss;
bool GL_NV_texgen_reflection;
bool GL_NV_texture_barrier;
bool GL_NV_texture_compression_vtc;
bool GL_NV_texture_env_combine4;
bool GL_NV_texture_expand_normal;
bool GL_NV_texture_multisample;
bool GL_NV_texture_rectangle;
bool GL_NV_texture_shader;
bool GL_NV_texture_shader2;
bool GL_NV_texture_shader3;
bool GL_NV_transform_feedback;
bool GL_NV_transform_feedback2;
bool GL_NV_uniform_buffer_unified_memory;
bool GL_NV_vdpau_interop;
bool GL_NV_vertex_array_range;
bool GL_NV_vertex_array_range2;
bool GL_NV_vertex_attrib_integer_64bit;
bool GL_NV_vertex_buffer_unified_memory;
bool GL_NV_vertex_program;
bool GL_NV_vertex_program1_1;
bool GL_NV_vertex_program2;
bool GL_NV_vertex_program2_option;
bool GL_NV_vertex_program3;
bool GL_NV_vertex_program4;
bool GL_NV_video_capture;
bool GL_NV_viewport_array2;
bool GL_OES_byte_coordinates;
bool GL_OES_compressed_paletted_texture;
bool GL_OES_fixed_point;
bool GL_OES_query_matrix;
bool GL_OES_read_format;
bool GL_OES_single_precision;
bool GL_OML_interlace;
bool GL_OML_resample;
bool GL_OML_subsample;
bool GL_OVR_multiview;
bool GL_OVR_multiview2;
bool GL_PGI_misc_hints;
bool GL_PGI_vertex_hints;
bool GL_REND_screen_coordinates;
bool GL_S3_s3tc;
bool GL_SGIS_detail_texture;
bool GL_SGIS_fog_function;
bool GL_SGIS_generate_mipmap;
bool GL_SGIS_multisample;
bool GL_SGIS_pixel_texture;
bool GL_SGIS_point_line_texgen;
bool GL_SGIS_point_parameters;
bool GL_SGIS_sharpen_texture;
bool GL_SGIS_texture4D;
bool GL_SGIS_texture_border_clamp;
bool GL_SGIS_texture_color_mask;
bool GL_SGIS_texture_edge_clamp;
bool GL_SGIS_texture_filter4;
bool GL_SGIS_texture_lod;
bool GL_SGIS_texture_select;
bool GL_SGIX_async;
bool GL_SGIX_async_histogram;
bool GL_SGIX_async_pixel;
bool GL_SGIX_blend_alpha_minmax;
bool GL_SGIX_calligraphic_fragment;
bool GL_SGIX_clipmap;
bool GL_SGIX_convolution_accuracy;
bool GL_SGIX_depth_pass_instrument;
bool GL_SGIX_depth_texture;
bool GL_SGIX_flush_raster;
bool GL_SGIX_fog_offset;
bool GL_SGIX_fragment_lighting;
bool GL_SGIX_framezoom;
bool GL_SGIX_igloo_interface;
bool GL_SGIX_instruments;
bool GL_SGIX_interlace;
bool GL_SGIX_ir_instrument1;
bool GL_SGIX_list_priority;
bool GL_SGIX_pixel_texture;
bool GL_SGIX_pixel_tiles;
bool GL_SGIX_polynomial_ffd;
bool GL_SGIX_reference_plane;
bool GL_SGIX_resample;
bool GL_SGIX_scalebias_hint;
bool GL_SGIX_shadow;
bool GL_SGIX_shadow_ambient;
bool GL_SGIX_sprite;
bool GL_SGIX_subsample;
bool GL_SGIX_tag_sample_buffer;
bool GL_SGIX_texture_add_env;
bool GL_SGIX_texture_coordinate_clamp;
bool GL_SGIX_texture_lod_bias;
bool GL_SGIX_texture_multi_buffer;
bool GL_SGIX_texture_scale_bias;
bool GL_SGIX_vertex_preclip;
bool GL_SGIX_ycrcb;
bool GL_SGIX_ycrcb_subsample;
bool GL_SGIX_ycrcba;
bool GL_SGI_color_matrix;
bool GL_SGI_color_table;
bool GL_SGI_texture_color_table;
bool GL_SUNX_constant_data;
bool GL_SUN_convolution_border_modes;
bool GL_SUN_global_alpha;
bool GL_SUN_mesh_array;
bool GL_SUN_slice_accum;
bool GL_SUN_triangle_list;
bool GL_SUN_vertex;
bool GL_WIN_phong_shading;
bool GL_WIN_specular_fog;
extern (System)
{
nothrow:
@nogc:
	alias fp_glTbufferMask3DFX = void function(GLuint);
	alias fp_glDebugMessageEnableAMD = void function(GLenum, GLenum, GLsizei,
		const(GLuint)*, GLboolean);
	alias fp_glDebugMessageInsertAMD = void function(GLenum, GLenum, GLuint,
		GLsizei, const(GLchar)*);
	alias fp_glDebugMessageCallbackAMD = void function(GLDEBUGPROCAMD, void*);
	alias fp_glGetDebugMessageLogAMD = GLuint function(GLuint, GLsizei,
		GLenum*, GLuint*, GLuint*, GLsizei*, GLchar*);
	alias fp_glBlendFuncIndexedAMD = void function(GLuint, GLenum, GLenum);
	alias fp_glBlendFuncSeparateIndexedAMD = void function(GLuint, GLenum, GLenum,
		GLenum, GLenum);
	alias fp_glBlendEquationIndexedAMD = void function(GLuint, GLenum);
	alias fp_glBlendEquationSeparateIndexedAMD = void function(GLuint, GLenum, GLenum);
	alias fp_glUniform1i64NV = void function(GLint, GLint64EXT);
	alias fp_glUniform2i64NV = void function(GLint, GLint64EXT, GLint64EXT);
	alias fp_glUniform3i64NV = void function(GLint, GLint64EXT, GLint64EXT, GLint64EXT);
	alias fp_glUniform4i64NV = void function(GLint, GLint64EXT, GLint64EXT,
		GLint64EXT, GLint64EXT);
	alias fp_glUniform1i64vNV = void function(GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glUniform2i64vNV = void function(GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glUniform3i64vNV = void function(GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glUniform4i64vNV = void function(GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glUniform1ui64NV = void function(GLint, GLuint64EXT);
	alias fp_glUniform2ui64NV = void function(GLint, GLuint64EXT, GLuint64EXT);
	alias fp_glUniform3ui64NV = void function(GLint, GLuint64EXT, GLuint64EXT, GLuint64EXT);
	alias fp_glUniform4ui64NV = void function(GLint, GLuint64EXT, GLuint64EXT,
		GLuint64EXT, GLuint64EXT);
	alias fp_glUniform1ui64vNV = void function(GLint, GLsizei, const(GLuint64EXT)*);
	alias fp_glUniform2ui64vNV = void function(GLint, GLsizei, const(GLuint64EXT)*);
	alias fp_glUniform3ui64vNV = void function(GLint, GLsizei, const(GLuint64EXT)*);
	alias fp_glUniform4ui64vNV = void function(GLint, GLsizei, const(GLuint64EXT)*);
	alias fp_glGetUniformi64vNV = void function(GLuint, GLint, GLint64EXT*);
	alias fp_glGetUniformui64vNV = void function(GLuint, GLint, GLuint64EXT*);
	alias fp_glProgramUniform1i64NV = void function(GLuint, GLint, GLint64EXT);
	alias fp_glProgramUniform2i64NV = void function(GLuint, GLint, GLint64EXT, GLint64EXT);
	alias fp_glProgramUniform3i64NV = void function(GLuint, GLint, GLint64EXT,
		GLint64EXT, GLint64EXT);
	alias fp_glProgramUniform4i64NV = void function(GLuint, GLint, GLint64EXT,
		GLint64EXT, GLint64EXT, GLint64EXT);
	alias fp_glProgramUniform1i64vNV = void function(GLuint, GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glProgramUniform2i64vNV = void function(GLuint, GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glProgramUniform3i64vNV = void function(GLuint, GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glProgramUniform4i64vNV = void function(GLuint, GLint, GLsizei, const(GLint64EXT)*);
	alias fp_glProgramUniform1ui64NV = void function(GLuint, GLint, GLuint64EXT);
	alias fp_glProgramUniform2ui64NV = void function(GLuint, GLint, GLuint64EXT, GLuint64EXT);
	alias fp_glProgramUniform3ui64NV = void function(GLuint, GLint,
		GLuint64EXT, GLuint64EXT, GLuint64EXT);
	alias fp_glProgramUniform4ui64NV = void function(GLuint, GLint,
		GLuint64EXT, GLuint64EXT, GLuint64EXT, GLuint64EXT);
	alias fp_glProgramUniform1ui64vNV = void function(GLuint, GLint, GLsizei,
		const(GLuint64EXT)*);
	alias fp_glProgramUniform2ui64vNV = void function(GLuint, GLint, GLsizei,
		const(GLuint64EXT)*);
	alias fp_glProgramUniform3ui64vNV = void function(GLuint, GLint, GLsizei,
		const(GLuint64EXT)*);
	alias fp_glProgramUniform4ui64vNV = void function(GLuint, GLint, GLsizei,
		const(GLuint64EXT)*);
	alias fp_glVertexAttribParameteriAMD = void function(GLuint, GLenum, GLint);
	alias fp_glMultiDrawArraysIndirectAMD = void function(GLenum, const(void)*, GLsizei,
		GLsizei);
	alias fp_glMultiDrawElementsIndirectAMD = void function(GLenum, GLenum,
		const(void)*, GLsizei, GLsizei);
	alias fp_glGenNamesAMD = void function(GLenum, GLuint, GLuint*);
	alias fp_glDeleteNamesAMD = void function(GLenum, GLuint, const(GLuint)*);
	alias fp_glIsNameAMD = GLboolean function(GLenum, GLuint);
	alias fp_glQueryObjectParameteruiAMD = void function(GLenum, GLuint, GLenum, GLuint);
	alias fp_glGetPerfMonitorGroupsAMD = void function(GLint*, GLsizei, GLuint*);
	alias fp_glGetPerfMonitorCountersAMD = void function(GLuint, GLint*,
		GLint*, GLsizei, GLuint*);
	alias fp_glGetPerfMonitorGroupStringAMD = void function(GLuint, GLsizei, GLsizei*,
		GLchar*);
	alias fp_glGetPerfMonitorCounterStringAMD = void function(GLuint, GLuint,
		GLsizei, GLsizei*, GLchar*);
	alias fp_glGetPerfMonitorCounterInfoAMD = void function(GLuint, GLuint, GLenum,
		void*);
	alias fp_glGenPerfMonitorsAMD = void function(GLsizei, GLuint*);
	alias fp_glDeletePerfMonitorsAMD = void function(GLsizei, GLuint*);
	alias fp_glSelectPerfMonitorCountersAMD = void function(GLuint, GLboolean,
		GLuint, GLint, GLuint*);
	alias fp_glBeginPerfMonitorAMD = void function(GLuint);
	alias fp_glEndPerfMonitorAMD = void function(GLuint);
	alias fp_glGetPerfMonitorCounterDataAMD = void function(GLuint, GLenum,
		GLsizei, GLuint*, GLint*);
	alias fp_glSetMultisamplefvAMD = void function(GLenum, GLuint, const(GLfloat)*);
	alias fp_glTexStorageSparseAMD = void function(GLenum, GLenum, GLsizei,
		GLsizei, GLsizei, GLsizei, GLbitfield);
	alias fp_glTextureStorageSparseAMD = void function(GLuint, GLenum, GLenum,
		GLsizei, GLsizei, GLsizei, GLsizei, GLbitfield);
	alias fp_glStencilOpValueAMD = void function(GLenum, GLuint);
	alias fp_glTessellationFactorAMD = void function(GLfloat);
	alias fp_glTessellationModeAMD = void function(GLenum);
	alias fp_glElementPointerAPPLE = void function(GLenum, const(void)*);
	alias fp_glDrawElementArrayAPPLE = void function(GLenum, GLint, GLsizei);
	alias fp_glDrawRangeElementArrayAPPLE = void function(GLenum, GLuint, GLuint, GLint,
		GLsizei);
	alias fp_glMultiDrawElementArrayAPPLE = void function(GLenum,
		const(GLint)*, const(GLsizei)*, GLsizei);
	alias fp_glMultiDrawRangeElementArrayAPPLE = void function(GLenum, GLuint,
		GLuint, const(GLint)*, const(GLsizei)*, GLsizei);
	alias fp_glGenFencesAPPLE = void function(GLsizei, GLuint*);
	alias fp_glDeleteFencesAPPLE = void function(GLsizei, const(GLuint)*);
	alias fp_glSetFenceAPPLE = void function(GLuint);
	alias fp_glIsFenceAPPLE = GLboolean function(GLuint);
	alias fp_glTestFenceAPPLE = GLboolean function(GLuint);
	alias fp_glFinishFenceAPPLE = void function(GLuint);
	alias fp_glTestObjectAPPLE = GLboolean function(GLenum, GLuint);
	alias fp_glFinishObjectAPPLE = void function(GLenum, GLint);
	alias fp_glBufferParameteriAPPLE = void function(GLenum, GLenum, GLint);
	alias fp_glFlushMappedBufferRangeAPPLE = void function(GLenum, GLintptr, GLsizeiptr);
	alias fp_glObjectPurgeableAPPLE = GLenum function(GLenum, GLuint, GLenum);
	alias fp_glObjectUnpurgeableAPPLE = GLenum function(GLenum, GLuint, GLenum);
	alias fp_glGetObjectParameterivAPPLE = void function(GLenum, GLuint, GLenum, GLint*);
	alias fp_glTextureRangeAPPLE = void function(GLenum, GLsizei, const(void)*);
	alias fp_glGetTexParameterPointervAPPLE = void function(GLenum, GLenum, void**);
	alias fp_glBindVertexArrayAPPLE = void function(GLuint);
	alias fp_glDeleteVertexArraysAPPLE = void function(GLsizei, const(GLuint)*);
	alias fp_glGenVertexArraysAPPLE = void function(GLsizei, GLuint*);
	alias fp_glIsVertexArrayAPPLE = GLboolean function(GLuint);
	alias fp_glVertexArrayRangeAPPLE = void function(GLsizei, void*);
	alias fp_glFlushVertexArrayRangeAPPLE = void function(GLsizei, void*);
	alias fp_glVertexArrayParameteriAPPLE = void function(GLenum, GLint);
	alias fp_glEnableVertexAttribAPPLE = void function(GLuint, GLenum);
	alias fp_glDisableVertexAttribAPPLE = void function(GLuint, GLenum);
	alias fp_glIsVertexAttribEnabledAPPLE = GLboolean function(GLuint, GLenum);
	alias fp_glMapVertexAttrib1dAPPLE = void function(GLuint, GLuint, GLdouble,
		GLdouble, GLint, GLint, const(GLdouble)*);
	alias fp_glMapVertexAttrib1fAPPLE = void function(GLuint, GLuint, GLfloat,
		GLfloat, GLint, GLint, const(GLfloat)*);
	alias fp_glMapVertexAttrib2dAPPLE = void function(GLuint, GLuint, GLdouble,
		GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, const(GLdouble)*);
	alias fp_glMapVertexAttrib2fAPPLE = void function(GLuint, GLuint, GLfloat,
		GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, const(GLfloat)*);
	alias fp_glReleaseShaderCompiler = void function();
	alias fp_glShaderBinary = void function(GLsizei, const(GLuint)*, GLenum,
		const(void)*, GLsizei);
	alias fp_glGetShaderPrecisionFormat = void function(GLenum, GLenum, GLint*, GLint*);
	alias fp_glDepthRangef = void function(GLfloat, GLfloat);
	alias fp_glClearDepthf = void function(GLfloat);
	alias fp_glMemoryBarrierByRegion = void function(GLbitfield);
	alias fp_glPrimitiveBoundingBoxARB = void function(GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glDrawArraysInstancedBaseInstance = void function(GLenum, GLint,
		GLsizei, GLsizei, GLuint);
	alias fp_glDrawElementsInstancedBaseInstance = void function(GLenum,
		GLsizei, GLenum, const(void)*, GLsizei, GLuint);
	alias fp_glDrawElementsInstancedBaseVertexBaseInstance = void function(GLenum,
		GLsizei, GLenum, const(void)*, GLsizei, GLint, GLuint);
	alias fp_glGetTextureHandleARB = GLuint64 function(GLuint);
	alias fp_glGetTextureSamplerHandleARB = GLuint64 function(GLuint, GLuint);
	alias fp_glMakeTextureHandleResidentARB = void function(GLuint64);
	alias fp_glMakeTextureHandleNonResidentARB = void function(GLuint64);
	alias fp_glGetImageHandleARB = GLuint64 function(GLuint, GLint, GLboolean, GLint,
		GLenum);
	alias fp_glMakeImageHandleResidentARB = void function(GLuint64, GLenum);
	alias fp_glMakeImageHandleNonResidentARB = void function(GLuint64);
	alias fp_glUniformHandleui64ARB = void function(GLint, GLuint64);
	alias fp_glUniformHandleui64vARB = void function(GLint, GLsizei, const(GLuint64)*);
	alias fp_glProgramUniformHandleui64ARB = void function(GLuint, GLint, GLuint64);
	alias fp_glProgramUniformHandleui64vARB = void function(GLuint, GLint,
		GLsizei, const(GLuint64)*);
	alias fp_glIsTextureHandleResidentARB = GLboolean function(GLuint64);
	alias fp_glIsImageHandleResidentARB = GLboolean function(GLuint64);
	alias fp_glVertexAttribL1ui64ARB = void function(GLuint, GLuint64EXT);
	alias fp_glVertexAttribL1ui64vARB = void function(GLuint, const(GLuint64EXT)*);
	alias fp_glGetVertexAttribLui64vARB = void function(GLuint, GLenum, GLuint64EXT*);
	alias fp_glBufferStorage = void function(GLenum, GLsizeiptr, const(void)*, GLbitfield);
	alias fp_glCreateSyncFromCLeventARB = GLsync function(_cl_context*, _cl_event*,
		GLbitfield);
	alias fp_glClearBufferData = void function(GLenum, GLenum, GLenum, GLenum, const(void)*);
	alias fp_glClearBufferSubData = void function(GLenum, GLenum, GLintptr,
		GLsizeiptr, GLenum, GLenum, const(void)*);
	alias fp_glClearTexImage = void function(GLuint, GLint, GLenum, GLenum, const(void)*);
	alias fp_glClearTexSubImage = void function(GLuint, GLint, GLint, GLint,
		GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glClipControl = void function(GLenum, GLenum);
	alias fp_glClampColorARB = void function(GLenum, GLenum);
	alias fp_glDispatchCompute = void function(GLuint, GLuint, GLuint);
	alias fp_glDispatchComputeIndirect = void function(GLintptr);
	alias fp_glDispatchComputeGroupSizeARB = void function(GLuint, GLuint,
		GLuint, GLuint, GLuint, GLuint);
	alias fp_glCopyImageSubData = void function(GLuint, GLenum, GLint, GLint,
		GLint, GLint, GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei,
		GLsizei);
	alias fp_glDebugMessageControlARB = void function(GLenum, GLenum, GLenum,
		GLsizei, const(GLuint)*, GLboolean);
	alias fp_glDebugMessageInsertARB = void function(GLenum, GLenum, GLuint,
		GLenum, GLsizei, const(GLchar)*);
	alias fp_glDebugMessageCallbackARB = void function(GLDEBUGPROCARB, const(void)*);
	alias fp_glGetDebugMessageLogARB = GLuint function(GLuint, GLsizei,
		GLenum*, GLenum*, GLuint*, GLenum*, GLsizei*, GLchar*);
	alias fp_glCreateTransformFeedbacks = void function(GLsizei, GLuint*);
	alias fp_glTransformFeedbackBufferBase = void function(GLuint, GLuint, GLuint);
	alias fp_glTransformFeedbackBufferRange = void function(GLuint, GLuint,
		GLuint, GLintptr, GLsizeiptr);
	alias fp_glGetTransformFeedbackiv = void function(GLuint, GLenum, GLint*);
	alias fp_glGetTransformFeedbacki_v = void function(GLuint, GLenum, GLuint, GLint*);
	alias fp_glGetTransformFeedbacki64_v = void function(GLuint, GLenum, GLuint, GLint64*);
	alias fp_glCreateBuffers = void function(GLsizei, GLuint*);
	alias fp_glNamedBufferStorage = void function(GLuint, GLsizeiptr, const(void)*,
		GLbitfield);
	alias fp_glNamedBufferData = void function(GLuint, GLsizeiptr, const(void)*, GLenum);
	alias fp_glNamedBufferSubData = void function(GLuint, GLintptr, GLsizeiptr, const(void)*);
	alias fp_glCopyNamedBufferSubData = void function(GLuint, GLuint, GLintptr,
		GLintptr, GLsizeiptr);
	alias fp_glClearNamedBufferData = void function(GLuint, GLenum, GLenum, GLenum,
		const(void)*);
	alias fp_glClearNamedBufferSubData = void function(GLuint, GLenum,
		GLintptr, GLsizeiptr, GLenum, GLenum, const(void)*);
	alias fp_glMapNamedBuffer = void* function(GLuint, GLenum);
	alias fp_glMapNamedBufferRange = void* function(GLuint, GLintptr, GLsizeiptr, GLbitfield);
	alias fp_glUnmapNamedBuffer = GLboolean function(GLuint);
	alias fp_glFlushMappedNamedBufferRange = void function(GLuint, GLintptr, GLsizeiptr);
	alias fp_glGetNamedBufferParameteriv = void function(GLuint, GLenum, GLint*);
	alias fp_glGetNamedBufferParameteri64v = void function(GLuint, GLenum, GLint64*);
	alias fp_glGetNamedBufferPointerv = void function(GLuint, GLenum, void**);
	alias fp_glGetNamedBufferSubData = void function(GLuint, GLintptr, GLsizeiptr,
		void*);
	alias fp_glCreateFramebuffers = void function(GLsizei, GLuint*);
	alias fp_glNamedFramebufferRenderbuffer = void function(GLuint, GLenum, GLenum,
		GLuint);
	alias fp_glNamedFramebufferParameteri = void function(GLuint, GLenum, GLint);
	alias fp_glNamedFramebufferTexture = void function(GLuint, GLenum, GLuint, GLint);
	alias fp_glNamedFramebufferTextureLayer = void function(GLuint, GLenum, GLuint,
		GLint, GLint);
	alias fp_glNamedFramebufferDrawBuffer = void function(GLuint, GLenum);
	alias fp_glNamedFramebufferDrawBuffers = void function(GLuint, GLsizei, const(GLenum)*);
	alias fp_glNamedFramebufferReadBuffer = void function(GLuint, GLenum);
	alias fp_glInvalidateNamedFramebufferData = void function(GLuint, GLsizei, const(GLenum)*);
	alias fp_glInvalidateNamedFramebufferSubData = void function(GLuint,
		GLsizei, const(GLenum)*, GLint, GLint, GLsizei, GLsizei);
	alias fp_glClearNamedFramebufferiv = void function(GLuint, GLenum, GLint, const(GLint)*);
	alias fp_glClearNamedFramebufferuiv = void function(GLuint, GLenum, GLint, const(GLuint)*);
	alias fp_glClearNamedFramebufferfv = void function(GLuint, GLenum, GLint, const(GLfloat)*);
	alias fp_glClearNamedFramebufferfi = void function(GLuint, GLenum, GLint, GLfloat,
		GLint);
	alias fp_glBlitNamedFramebuffer = void function(GLuint, GLuint, GLint,
		GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLbitfield, GLenum);
	alias fp_glCheckNamedFramebufferStatus = GLenum function(GLuint, GLenum);
	alias fp_glGetNamedFramebufferParameteriv = void function(GLuint, GLenum, GLint*);
	alias fp_glGetNamedFramebufferAttachmentParameteriv = void function(GLuint,
		GLenum, GLenum, GLint*);
	alias fp_glCreateRenderbuffers = void function(GLsizei, GLuint*);
	alias fp_glNamedRenderbufferStorage = void function(GLuint, GLenum, GLsizei, GLsizei);
	alias fp_glNamedRenderbufferStorageMultisample = void function(GLuint,
		GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glGetNamedRenderbufferParameteriv = void function(GLuint, GLenum, GLint*);
	alias fp_glCreateTextures = void function(GLenum, GLsizei, GLuint*);
	alias fp_glTextureBuffer = void function(GLuint, GLenum, GLuint);
	alias fp_glTextureBufferRange = void function(GLuint, GLenum, GLuint, GLintptr,
		GLsizeiptr);
	alias fp_glTextureStorage1D = void function(GLuint, GLsizei, GLenum, GLsizei);
	alias fp_glTextureStorage2D = void function(GLuint, GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glTextureStorage3D = void function(GLuint, GLsizei, GLenum,
		GLsizei, GLsizei, GLsizei);
	alias fp_glTextureStorage2DMultisample = void function(GLuint, GLsizei,
		GLenum, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureStorage3DMultisample = void function(GLuint, GLsizei,
		GLenum, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureSubImage1D = void function(GLuint, GLint, GLint, GLsizei,
		GLenum, GLenum, const(void)*);
	alias fp_glTextureSubImage2D = void function(GLuint, GLint, GLint, GLint,
		GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glTextureSubImage3D = void function(GLuint, GLint, GLint, GLint,
		GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glCompressedTextureSubImage1D = void function(GLuint, GLint,
		GLint, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedTextureSubImage2D = void function(GLuint, GLint,
		GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedTextureSubImage3D = void function(GLuint, GLint,
		GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCopyTextureSubImage1D = void function(GLuint, GLint, GLint, GLint, GLint,
		GLsizei);
	alias fp_glCopyTextureSubImage2D = void function(GLuint, GLint, GLint,
		GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glCopyTextureSubImage3D = void function(GLuint, GLint, GLint,
		GLint, GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glTextureParameterf = void function(GLuint, GLenum, GLfloat);
	alias fp_glTextureParameterfv = void function(GLuint, GLenum, const(GLfloat)*);
	alias fp_glTextureParameteri = void function(GLuint, GLenum, GLint);
	alias fp_glTextureParameterIiv = void function(GLuint, GLenum, const(GLint)*);
	alias fp_glTextureParameterIuiv = void function(GLuint, GLenum, const(GLuint)*);
	alias fp_glTextureParameteriv = void function(GLuint, GLenum, const(GLint)*);
	alias fp_glGenerateTextureMipmap = void function(GLuint);
	alias fp_glBindTextureUnit = void function(GLuint, GLuint);
	alias fp_glGetTextureImage = void function(GLuint, GLint, GLenum, GLenum, GLsizei,
		void*);
	alias fp_glGetCompressedTextureImage = void function(GLuint, GLint, GLsizei, void*);
	alias fp_glGetTextureLevelParameterfv = void function(GLuint, GLint, GLenum, GLfloat*);
	alias fp_glGetTextureLevelParameteriv = void function(GLuint, GLint, GLenum, GLint*);
	alias fp_glGetTextureParameterfv = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetTextureParameterIiv = void function(GLuint, GLenum, GLint*);
	alias fp_glGetTextureParameterIuiv = void function(GLuint, GLenum, GLuint*);
	alias fp_glGetTextureParameteriv = void function(GLuint, GLenum, GLint*);
	alias fp_glCreateVertexArrays = void function(GLsizei, GLuint*);
	alias fp_glDisableVertexArrayAttrib = void function(GLuint, GLuint);
	alias fp_glEnableVertexArrayAttrib = void function(GLuint, GLuint);
	alias fp_glVertexArrayElementBuffer = void function(GLuint, GLuint);
	alias fp_glVertexArrayVertexBuffer = void function(GLuint, GLuint, GLuint, GLintptr,
		GLsizei);
	alias fp_glVertexArrayVertexBuffers = void function(GLuint, GLuint,
		GLsizei, const(GLuint)*, const(GLintptr)*, const(GLsizei)*);
	alias fp_glVertexArrayAttribBinding = void function(GLuint, GLuint, GLuint);
	alias fp_glVertexArrayAttribFormat = void function(GLuint, GLuint, GLint,
		GLenum, GLboolean, GLuint);
	alias fp_glVertexArrayAttribIFormat = void function(GLuint, GLuint, GLint, GLenum,
		GLuint);
	alias fp_glVertexArrayAttribLFormat = void function(GLuint, GLuint, GLint, GLenum,
		GLuint);
	alias fp_glVertexArrayBindingDivisor = void function(GLuint, GLuint, GLuint);
	alias fp_glGetVertexArrayiv = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVertexArrayIndexediv = void function(GLuint, GLuint, GLenum, GLint*);
	alias fp_glGetVertexArrayIndexed64iv = void function(GLuint, GLuint, GLenum, GLint64*);
	alias fp_glCreateSamplers = void function(GLsizei, GLuint*);
	alias fp_glCreateProgramPipelines = void function(GLsizei, GLuint*);
	alias fp_glCreateQueries = void function(GLenum, GLsizei, GLuint*);
	alias fp_glGetQueryBufferObjecti64v = void function(GLuint, GLuint, GLenum, GLintptr);
	alias fp_glGetQueryBufferObjectiv = void function(GLuint, GLuint, GLenum, GLintptr);
	alias fp_glGetQueryBufferObjectui64v = void function(GLuint, GLuint, GLenum, GLintptr);
	alias fp_glGetQueryBufferObjectuiv = void function(GLuint, GLuint, GLenum, GLintptr);
	alias fp_glDrawBuffersARB = void function(GLsizei, const(GLenum)*);
	alias fp_glBlendEquationiARB = void function(GLuint, GLenum);
	alias fp_glBlendEquationSeparateiARB = void function(GLuint, GLenum, GLenum);
	alias fp_glBlendFunciARB = void function(GLuint, GLenum, GLenum);
	alias fp_glBlendFuncSeparateiARB = void function(GLuint, GLenum, GLenum, GLenum,
		GLenum);
	alias fp_glDrawArraysIndirect = void function(GLenum, const(void)*);
	alias fp_glDrawElementsIndirect = void function(GLenum, GLenum, const(void)*);
	alias fp_glDrawArraysInstancedARB = void function(GLenum, GLint, GLsizei, GLsizei);
	alias fp_glDrawElementsInstancedARB = void function(GLenum, GLsizei,
		GLenum, const(void)*, GLsizei);
	alias fp_glProgramStringARB = void function(GLenum, GLenum, GLsizei, const(void)*);
	alias fp_glBindProgramARB = void function(GLenum, GLuint);
	alias fp_glDeleteProgramsARB = void function(GLsizei, const(GLuint)*);
	alias fp_glGenProgramsARB = void function(GLsizei, GLuint*);
	alias fp_glProgramEnvParameter4dARB = void function(GLenum, GLuint,
		GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glProgramEnvParameter4dvARB = void function(GLenum, GLuint, const(GLdouble)*);
	alias fp_glProgramEnvParameter4fARB = void function(GLenum, GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glProgramEnvParameter4fvARB = void function(GLenum, GLuint, const(GLfloat)*);
	alias fp_glProgramLocalParameter4dARB = void function(GLenum, GLuint,
		GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glProgramLocalParameter4dvARB = void function(GLenum, GLuint, const(GLdouble)*);
	alias fp_glProgramLocalParameter4fARB = void function(GLenum, GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glProgramLocalParameter4fvARB = void function(GLenum, GLuint, const(GLfloat)*);
	alias fp_glGetProgramEnvParameterdvARB = void function(GLenum, GLuint, GLdouble*);
	alias fp_glGetProgramEnvParameterfvARB = void function(GLenum, GLuint, GLfloat*);
	alias fp_glGetProgramLocalParameterdvARB = void function(GLenum, GLuint, GLdouble*);
	alias fp_glGetProgramLocalParameterfvARB = void function(GLenum, GLuint, GLfloat*);
	alias fp_glGetProgramivARB = void function(GLenum, GLenum, GLint*);
	alias fp_glGetProgramStringARB = void function(GLenum, GLenum, void*);
	alias fp_glIsProgramARB = GLboolean function(GLuint);
	alias fp_glFramebufferParameteri = void function(GLenum, GLenum, GLint);
	alias fp_glGetFramebufferParameteriv = void function(GLenum, GLenum, GLint*);
	alias fp_glProgramParameteriARB = void function(GLuint, GLenum, GLint);
	alias fp_glFramebufferTextureARB = void function(GLenum, GLenum, GLuint, GLint);
	alias fp_glFramebufferTextureLayerARB = void function(GLenum, GLenum, GLuint, GLint,
		GLint);
	alias fp_glFramebufferTextureFaceARB = void function(GLenum, GLenum, GLuint, GLint,
		GLenum);
	alias fp_glGetProgramBinary = void function(GLuint, GLsizei, GLsizei*, GLenum*,
		void*);
	alias fp_glProgramBinary = void function(GLuint, GLenum, const(void)*, GLsizei);
	alias fp_glProgramParameteri = void function(GLuint, GLenum, GLint);
	alias fp_glGetTextureSubImage = void function(GLuint, GLint, GLint, GLint,
		GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLsizei, void*);
	alias fp_glGetCompressedTextureSubImage = void function(GLuint, GLint,
		GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLsizei, void*);
	alias fp_glUniform1d = void function(GLint, GLdouble);
	alias fp_glUniform2d = void function(GLint, GLdouble, GLdouble);
	alias fp_glUniform3d = void function(GLint, GLdouble, GLdouble, GLdouble);
	alias fp_glUniform4d = void function(GLint, GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glUniform1dv = void function(GLint, GLsizei, const(GLdouble)*);
	alias fp_glUniform2dv = void function(GLint, GLsizei, const(GLdouble)*);
	alias fp_glUniform3dv = void function(GLint, GLsizei, const(GLdouble)*);
	alias fp_glUniform4dv = void function(GLint, GLsizei, const(GLdouble)*);
	alias fp_glUniformMatrix2dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix3dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix4dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix2x3dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix2x4dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix3x2dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix3x4dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix4x2dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glUniformMatrix4x3dv = void function(GLint, GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glGetUniformdv = void function(GLuint, GLint, GLdouble*);
	alias fp_glUniform1i64ARB = void function(GLint, GLint64);
	alias fp_glUniform2i64ARB = void function(GLint, GLint64, GLint64);
	alias fp_glUniform3i64ARB = void function(GLint, GLint64, GLint64, GLint64);
	alias fp_glUniform4i64ARB = void function(GLint, GLint64, GLint64, GLint64, GLint64);
	alias fp_glUniform1i64vARB = void function(GLint, GLsizei, const(GLint64)*);
	alias fp_glUniform2i64vARB = void function(GLint, GLsizei, const(GLint64)*);
	alias fp_glUniform3i64vARB = void function(GLint, GLsizei, const(GLint64)*);
	alias fp_glUniform4i64vARB = void function(GLint, GLsizei, const(GLint64)*);
	alias fp_glUniform1ui64ARB = void function(GLint, GLuint64);
	alias fp_glUniform2ui64ARB = void function(GLint, GLuint64, GLuint64);
	alias fp_glUniform3ui64ARB = void function(GLint, GLuint64, GLuint64, GLuint64);
	alias fp_glUniform4ui64ARB = void function(GLint, GLuint64, GLuint64, GLuint64,
		GLuint64);
	alias fp_glUniform1ui64vARB = void function(GLint, GLsizei, const(GLuint64)*);
	alias fp_glUniform2ui64vARB = void function(GLint, GLsizei, const(GLuint64)*);
	alias fp_glUniform3ui64vARB = void function(GLint, GLsizei, const(GLuint64)*);
	alias fp_glUniform4ui64vARB = void function(GLint, GLsizei, const(GLuint64)*);
	alias fp_glGetUniformi64vARB = void function(GLuint, GLint, GLint64*);
	alias fp_glGetUniformui64vARB = void function(GLuint, GLint, GLuint64*);
	alias fp_glGetnUniformi64vARB = void function(GLuint, GLint, GLsizei, GLint64*);
	alias fp_glGetnUniformui64vARB = void function(GLuint, GLint, GLsizei, GLuint64*);
	alias fp_glProgramUniform1i64ARB = void function(GLuint, GLint, GLint64);
	alias fp_glProgramUniform2i64ARB = void function(GLuint, GLint, GLint64, GLint64);
	alias fp_glProgramUniform3i64ARB = void function(GLuint, GLint, GLint64, GLint64,
		GLint64);
	alias fp_glProgramUniform4i64ARB = void function(GLuint, GLint, GLint64,
		GLint64, GLint64, GLint64);
	alias fp_glProgramUniform1i64vARB = void function(GLuint, GLint, GLsizei, const(GLint64)*);
	alias fp_glProgramUniform2i64vARB = void function(GLuint, GLint, GLsizei, const(GLint64)*);
	alias fp_glProgramUniform3i64vARB = void function(GLuint, GLint, GLsizei, const(GLint64)*);
	alias fp_glProgramUniform4i64vARB = void function(GLuint, GLint, GLsizei, const(GLint64)*);
	alias fp_glProgramUniform1ui64ARB = void function(GLuint, GLint, GLuint64);
	alias fp_glProgramUniform2ui64ARB = void function(GLuint, GLint, GLuint64, GLuint64);
	alias fp_glProgramUniform3ui64ARB = void function(GLuint, GLint, GLuint64, GLuint64,
		GLuint64);
	alias fp_glProgramUniform4ui64ARB = void function(GLuint, GLint, GLuint64,
		GLuint64, GLuint64, GLuint64);
	alias fp_glProgramUniform1ui64vARB = void function(GLuint, GLint, GLsizei, const(GLuint64)*);
	alias fp_glProgramUniform2ui64vARB = void function(GLuint, GLint, GLsizei, const(GLuint64)*);
	alias fp_glProgramUniform3ui64vARB = void function(GLuint, GLint, GLsizei, const(GLuint64)*);
	alias fp_glProgramUniform4ui64vARB = void function(GLuint, GLint, GLsizei, const(GLuint64)*);
	alias fp_glColorTable = void function(GLenum, GLenum, GLsizei, GLenum, GLenum,
		const(void)*);
	alias fp_glColorTableParameterfv = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glColorTableParameteriv = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glCopyColorTable = void function(GLenum, GLenum, GLint, GLint, GLsizei);
	alias fp_glGetColorTable = void function(GLenum, GLenum, GLenum, void*);
	alias fp_glGetColorTableParameterfv = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetColorTableParameteriv = void function(GLenum, GLenum, GLint*);
	alias fp_glColorSubTable = void function(GLenum, GLsizei, GLsizei, GLenum,
		GLenum, const(void)*);
	alias fp_glCopyColorSubTable = void function(GLenum, GLsizei, GLint, GLint, GLsizei);
	alias fp_glConvolutionFilter1D = void function(GLenum, GLenum, GLsizei,
		GLenum, GLenum, const(void)*);
	alias fp_glConvolutionFilter2D = void function(GLenum, GLenum, GLsizei,
		GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glConvolutionParameterf = void function(GLenum, GLenum, GLfloat);
	alias fp_glConvolutionParameterfv = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glConvolutionParameteri = void function(GLenum, GLenum, GLint);
	alias fp_glConvolutionParameteriv = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glCopyConvolutionFilter1D = void function(GLenum, GLenum, GLint, GLint,
		GLsizei);
	alias fp_glCopyConvolutionFilter2D = void function(GLenum, GLenum, GLint,
		GLint, GLsizei, GLsizei);
	alias fp_glGetConvolutionFilter = void function(GLenum, GLenum, GLenum, void*);
	alias fp_glGetConvolutionParameterfv = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetConvolutionParameteriv = void function(GLenum, GLenum, GLint*);
	alias fp_glGetSeparableFilter = void function(GLenum, GLenum, GLenum, void*, void*,
		void*);
	alias fp_glSeparableFilter2D = void function(GLenum, GLenum, GLsizei,
		GLsizei, GLenum, GLenum, const(void)*, const(void)*);
	alias fp_glGetHistogram = void function(GLenum, GLboolean, GLenum, GLenum, void*);
	alias fp_glGetHistogramParameterfv = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetHistogramParameteriv = void function(GLenum, GLenum, GLint*);
	alias fp_glGetMinmax = void function(GLenum, GLboolean, GLenum, GLenum, void*);
	alias fp_glGetMinmaxParameterfv = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetMinmaxParameteriv = void function(GLenum, GLenum, GLint*);
	alias fp_glHistogram = void function(GLenum, GLsizei, GLenum, GLboolean);
	alias fp_glMinmax = void function(GLenum, GLenum, GLboolean);
	alias fp_glResetHistogram = void function(GLenum);
	alias fp_glResetMinmax = void function(GLenum);
	alias fp_glMultiDrawArraysIndirectCountARB = void function(GLenum,
		GLintptr, GLintptr, GLsizei, GLsizei);
	alias fp_glMultiDrawElementsIndirectCountARB = void function(GLenum,
		GLenum, GLintptr, GLintptr, GLsizei, GLsizei);
	alias fp_glVertexAttribDivisorARB = void function(GLuint, GLuint);
	alias fp_glGetInternalformativ = void function(GLenum, GLenum, GLenum, GLsizei,
		GLint*);
	alias fp_glGetInternalformati64v = void function(GLenum, GLenum, GLenum, GLsizei,
		GLint64*);
	alias fp_glInvalidateTexSubImage = void function(GLuint, GLint, GLint,
		GLint, GLint, GLsizei, GLsizei, GLsizei);
	alias fp_glInvalidateTexImage = void function(GLuint, GLint);
	alias fp_glInvalidateBufferSubData = void function(GLuint, GLintptr, GLsizeiptr);
	alias fp_glInvalidateBufferData = void function(GLuint);
	alias fp_glInvalidateFramebuffer = void function(GLenum, GLsizei, const(GLenum)*);
	alias fp_glInvalidateSubFramebuffer = void function(GLenum, GLsizei,
		const(GLenum)*, GLint, GLint, GLsizei, GLsizei);
	alias fp_glCurrentPaletteMatrixARB = void function(GLint);
	alias fp_glMatrixIndexubvARB = void function(GLint, const(GLubyte)*);
	alias fp_glMatrixIndexusvARB = void function(GLint, const(GLushort)*);
	alias fp_glMatrixIndexuivARB = void function(GLint, const(GLuint)*);
	alias fp_glMatrixIndexPointerARB = void function(GLint, GLenum, GLsizei, const(void)*);
	alias fp_glBindBuffersBase = void function(GLenum, GLuint, GLsizei, const(GLuint)*);
	alias fp_glBindBuffersRange = void function(GLenum, GLuint, GLsizei,
		const(GLuint)*, const(GLintptr)*, const(GLsizeiptr)*);
	alias fp_glBindTextures = void function(GLuint, GLsizei, const(GLuint)*);
	alias fp_glBindSamplers = void function(GLuint, GLsizei, const(GLuint)*);
	alias fp_glBindImageTextures = void function(GLuint, GLsizei, const(GLuint)*);
	alias fp_glBindVertexBuffers = void function(GLuint, GLsizei,
		const(GLuint)*, const(GLintptr)*, const(GLsizei)*);
	alias fp_glMultiDrawArraysIndirect = void function(GLenum, const(void)*, GLsizei,
		GLsizei);
	alias fp_glMultiDrawElementsIndirect = void function(GLenum, GLenum,
		const(void)*, GLsizei, GLsizei);
	alias fp_glSampleCoverageARB = void function(GLfloat, GLboolean);
	alias fp_glActiveTextureARB = void function(GLenum);
	alias fp_glClientActiveTextureARB = void function(GLenum);
	alias fp_glMultiTexCoord1dARB = void function(GLenum, GLdouble);
	alias fp_glMultiTexCoord1dvARB = void function(GLenum, const(GLdouble)*);
	alias fp_glMultiTexCoord1fARB = void function(GLenum, GLfloat);
	alias fp_glMultiTexCoord1fvARB = void function(GLenum, const(GLfloat)*);
	alias fp_glMultiTexCoord1iARB = void function(GLenum, GLint);
	alias fp_glMultiTexCoord1ivARB = void function(GLenum, const(GLint)*);
	alias fp_glMultiTexCoord1sARB = void function(GLenum, GLshort);
	alias fp_glMultiTexCoord1svARB = void function(GLenum, const(GLshort)*);
	alias fp_glMultiTexCoord2dARB = void function(GLenum, GLdouble, GLdouble);
	alias fp_glMultiTexCoord2dvARB = void function(GLenum, const(GLdouble)*);
	alias fp_glMultiTexCoord2fARB = void function(GLenum, GLfloat, GLfloat);
	alias fp_glMultiTexCoord2fvARB = void function(GLenum, const(GLfloat)*);
	alias fp_glMultiTexCoord2iARB = void function(GLenum, GLint, GLint);
	alias fp_glMultiTexCoord2ivARB = void function(GLenum, const(GLint)*);
	alias fp_glMultiTexCoord2sARB = void function(GLenum, GLshort, GLshort);
	alias fp_glMultiTexCoord2svARB = void function(GLenum, const(GLshort)*);
	alias fp_glMultiTexCoord3dARB = void function(GLenum, GLdouble, GLdouble, GLdouble);
	alias fp_glMultiTexCoord3dvARB = void function(GLenum, const(GLdouble)*);
	alias fp_glMultiTexCoord3fARB = void function(GLenum, GLfloat, GLfloat, GLfloat);
	alias fp_glMultiTexCoord3fvARB = void function(GLenum, const(GLfloat)*);
	alias fp_glMultiTexCoord3iARB = void function(GLenum, GLint, GLint, GLint);
	alias fp_glMultiTexCoord3ivARB = void function(GLenum, const(GLint)*);
	alias fp_glMultiTexCoord3sARB = void function(GLenum, GLshort, GLshort, GLshort);
	alias fp_glMultiTexCoord3svARB = void function(GLenum, const(GLshort)*);
	alias fp_glMultiTexCoord4dARB = void function(GLenum, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glMultiTexCoord4dvARB = void function(GLenum, const(GLdouble)*);
	alias fp_glMultiTexCoord4fARB = void function(GLenum, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glMultiTexCoord4fvARB = void function(GLenum, const(GLfloat)*);
	alias fp_glMultiTexCoord4iARB = void function(GLenum, GLint, GLint, GLint, GLint);
	alias fp_glMultiTexCoord4ivARB = void function(GLenum, const(GLint)*);
	alias fp_glMultiTexCoord4sARB = void function(GLenum, GLshort, GLshort, GLshort,
		GLshort);
	alias fp_glMultiTexCoord4svARB = void function(GLenum, const(GLshort)*);
	alias fp_glGenQueriesARB = void function(GLsizei, GLuint*);
	alias fp_glDeleteQueriesARB = void function(GLsizei, const(GLuint)*);
	alias fp_glIsQueryARB = GLboolean function(GLuint);
	alias fp_glBeginQueryARB = void function(GLenum, GLuint);
	alias fp_glEndQueryARB = void function(GLenum);
	alias fp_glGetQueryivARB = void function(GLenum, GLenum, GLint*);
	alias fp_glGetQueryObjectivARB = void function(GLuint, GLenum, GLint*);
	alias fp_glGetQueryObjectuivARB = void function(GLuint, GLenum, GLuint*);
	alias fp_glMaxShaderCompilerThreadsARB = void function(GLuint);
	alias fp_glPointParameterfARB = void function(GLenum, GLfloat);
	alias fp_glPointParameterfvARB = void function(GLenum, const(GLfloat)*);
	alias fp_glGetProgramInterfaceiv = void function(GLuint, GLenum, GLenum, GLint*);
	alias fp_glGetProgramResourceIndex = GLuint function(GLuint, GLenum, const(GLchar)*);
	alias fp_glGetProgramResourceName = void function(GLuint, GLenum, GLuint,
		GLsizei, GLsizei*, GLchar*);
	alias fp_glGetProgramResourceiv = void function(GLuint, GLenum, GLuint,
		GLsizei, const(GLenum)*, GLsizei, GLsizei*, GLint*);
	alias fp_glGetProgramResourceLocation = GLint function(GLuint, GLenum, const(GLchar)*);
	alias fp_glGetProgramResourceLocationIndex = GLint function(GLuint, GLenum, const(GLchar)*);
	alias fp_glGetGraphicsResetStatusARB = GLenum function();
	alias fp_glGetnTexImageARB = void function(GLenum, GLint, GLenum, GLenum, GLsizei,
		void*);
	alias fp_glReadnPixelsARB = void function(GLint, GLint, GLsizei, GLsizei,
		GLenum, GLenum, GLsizei, void*);
	alias fp_glGetnCompressedTexImageARB = void function(GLenum, GLint, GLsizei, void*);
	alias fp_glGetnUniformfvARB = void function(GLuint, GLint, GLsizei, GLfloat*);
	alias fp_glGetnUniformivARB = void function(GLuint, GLint, GLsizei, GLint*);
	alias fp_glGetnUniformuivARB = void function(GLuint, GLint, GLsizei, GLuint*);
	alias fp_glGetnUniformdvARB = void function(GLuint, GLint, GLsizei, GLdouble*);
	alias fp_glGetnMapdvARB = void function(GLenum, GLenum, GLsizei, GLdouble*);
	alias fp_glGetnMapfvARB = void function(GLenum, GLenum, GLsizei, GLfloat*);
	alias fp_glGetnMapivARB = void function(GLenum, GLenum, GLsizei, GLint*);
	alias fp_glGetnPixelMapfvARB = void function(GLenum, GLsizei, GLfloat*);
	alias fp_glGetnPixelMapuivARB = void function(GLenum, GLsizei, GLuint*);
	alias fp_glGetnPixelMapusvARB = void function(GLenum, GLsizei, GLushort*);
	alias fp_glGetnPolygonStippleARB = void function(GLsizei, GLubyte*);
	alias fp_glGetnColorTableARB = void function(GLenum, GLenum, GLenum, GLsizei, void*);
	alias fp_glGetnConvolutionFilterARB = void function(GLenum, GLenum, GLenum, GLsizei,
		void*);
	alias fp_glGetnSeparableFilterARB = void function(GLenum, GLenum, GLenum,
		GLsizei, void*, GLsizei, void*, void*);
	alias fp_glGetnHistogramARB = void function(GLenum, GLboolean, GLenum,
		GLenum, GLsizei, void*);
	alias fp_glGetnMinmaxARB = void function(GLenum, GLboolean, GLenum, GLenum, GLsizei,
		void*);
	alias fp_glFramebufferSampleLocationsfvARB = void function(GLenum, GLuint,
		GLsizei, const(GLfloat)*);
	alias fp_glNamedFramebufferSampleLocationsfvARB = void function(GLuint,
		GLuint, GLsizei, const(GLfloat)*);
	alias fp_glEvaluateDepthValuesARB = void function();
	alias fp_glMinSampleShadingARB = void function(GLfloat);
	alias fp_glUseProgramStages = void function(GLuint, GLbitfield, GLuint);
	alias fp_glActiveShaderProgram = void function(GLuint, GLuint);
	alias fp_glCreateShaderProgramv = GLuint function(GLenum, GLsizei, const(GLchar*)*);
	alias fp_glBindProgramPipeline = void function(GLuint);
	alias fp_glDeleteProgramPipelines = void function(GLsizei, const(GLuint)*);
	alias fp_glGenProgramPipelines = void function(GLsizei, GLuint*);
	alias fp_glIsProgramPipeline = GLboolean function(GLuint);
	alias fp_glGetProgramPipelineiv = void function(GLuint, GLenum, GLint*);
	alias fp_glProgramUniform1i = void function(GLuint, GLint, GLint);
	alias fp_glProgramUniform1iv = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform1f = void function(GLuint, GLint, GLfloat);
	alias fp_glProgramUniform1fv = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform1d = void function(GLuint, GLint, GLdouble);
	alias fp_glProgramUniform1dv = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform1ui = void function(GLuint, GLint, GLuint);
	alias fp_glProgramUniform1uiv = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniform2i = void function(GLuint, GLint, GLint, GLint);
	alias fp_glProgramUniform2iv = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform2f = void function(GLuint, GLint, GLfloat, GLfloat);
	alias fp_glProgramUniform2fv = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform2d = void function(GLuint, GLint, GLdouble, GLdouble);
	alias fp_glProgramUniform2dv = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform2ui = void function(GLuint, GLint, GLuint, GLuint);
	alias fp_glProgramUniform2uiv = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniform3i = void function(GLuint, GLint, GLint, GLint, GLint);
	alias fp_glProgramUniform3iv = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform3f = void function(GLuint, GLint, GLfloat, GLfloat, GLfloat);
	alias fp_glProgramUniform3fv = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform3d = void function(GLuint, GLint, GLdouble, GLdouble,
		GLdouble);
	alias fp_glProgramUniform3dv = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform3ui = void function(GLuint, GLint, GLuint, GLuint, GLuint);
	alias fp_glProgramUniform3uiv = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniform4i = void function(GLuint, GLint, GLint, GLint, GLint,
		GLint);
	alias fp_glProgramUniform4iv = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform4f = void function(GLuint, GLint, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glProgramUniform4fv = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform4d = void function(GLuint, GLint, GLdouble,
		GLdouble, GLdouble, GLdouble);
	alias fp_glProgramUniform4dv = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform4ui = void function(GLuint, GLint, GLuint, GLuint, GLuint,
		GLuint);
	alias fp_glProgramUniform4uiv = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniformMatrix2fv = void function(GLuint, GLint, GLsizei,
		GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix3fv = void function(GLuint, GLint, GLsizei,
		GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix4fv = void function(GLuint, GLint, GLsizei,
		GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix2dv = void function(GLuint, GLint, GLsizei,
		GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix3dv = void function(GLuint, GLint, GLsizei,
		GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix4dv = void function(GLuint, GLint, GLsizei,
		GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix2x3fv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix3x2fv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix2x4fv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix4x2fv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix3x4fv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix4x3fv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix2x3dv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix3x2dv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix2x4dv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix4x2dv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix3x4dv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix4x3dv = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glValidateProgramPipeline = void function(GLuint);
	alias fp_glGetProgramPipelineInfoLog = void function(GLuint, GLsizei, GLsizei*,
		GLchar*);
	alias fp_glGetActiveAtomicCounterBufferiv = void function(GLuint, GLuint, GLenum,
		GLint*);
	alias fp_glBindImageTexture = void function(GLuint, GLuint, GLint,
		GLboolean, GLint, GLenum, GLenum);
	alias fp_glMemoryBarrier = void function(GLbitfield);
	alias fp_glDeleteObjectARB = void function(GLhandleARB);
	alias fp_glGetHandleARB = GLhandleARB function(GLenum);
	alias fp_glDetachObjectARB = void function(GLhandleARB, GLhandleARB);
	alias fp_glCreateShaderObjectARB = GLhandleARB function(GLenum);
	alias fp_glShaderSourceARB = void function(GLhandleARB, GLsizei,
		const(GLcharARB*)*, const(GLint)*);
	alias fp_glCompileShaderARB = void function(GLhandleARB);
	alias fp_glCreateProgramObjectARB = GLhandleARB function();
	alias fp_glAttachObjectARB = void function(GLhandleARB, GLhandleARB);
	alias fp_glLinkProgramARB = void function(GLhandleARB);
	alias fp_glUseProgramObjectARB = void function(GLhandleARB);
	alias fp_glValidateProgramARB = void function(GLhandleARB);
	alias fp_glUniform1fARB = void function(GLint, GLfloat);
	alias fp_glUniform2fARB = void function(GLint, GLfloat, GLfloat);
	alias fp_glUniform3fARB = void function(GLint, GLfloat, GLfloat, GLfloat);
	alias fp_glUniform4fARB = void function(GLint, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glUniform1iARB = void function(GLint, GLint);
	alias fp_glUniform2iARB = void function(GLint, GLint, GLint);
	alias fp_glUniform3iARB = void function(GLint, GLint, GLint, GLint);
	alias fp_glUniform4iARB = void function(GLint, GLint, GLint, GLint, GLint);
	alias fp_glUniform1fvARB = void function(GLint, GLsizei, const(GLfloat)*);
	alias fp_glUniform2fvARB = void function(GLint, GLsizei, const(GLfloat)*);
	alias fp_glUniform3fvARB = void function(GLint, GLsizei, const(GLfloat)*);
	alias fp_glUniform4fvARB = void function(GLint, GLsizei, const(GLfloat)*);
	alias fp_glUniform1ivARB = void function(GLint, GLsizei, const(GLint)*);
	alias fp_glUniform2ivARB = void function(GLint, GLsizei, const(GLint)*);
	alias fp_glUniform3ivARB = void function(GLint, GLsizei, const(GLint)*);
	alias fp_glUniform4ivARB = void function(GLint, GLsizei, const(GLint)*);
	alias fp_glUniformMatrix2fvARB = void function(GLint, GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glUniformMatrix3fvARB = void function(GLint, GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glUniformMatrix4fvARB = void function(GLint, GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glGetObjectParameterfvARB = void function(GLhandleARB, GLenum, GLfloat*);
	alias fp_glGetObjectParameterivARB = void function(GLhandleARB, GLenum, GLint*);
	alias fp_glGetInfoLogARB = void function(GLhandleARB, GLsizei, GLsizei*, GLcharARB*);
	alias fp_glGetAttachedObjectsARB = void function(GLhandleARB, GLsizei,
		GLsizei*, GLhandleARB*);
	alias fp_glGetUniformLocationARB = GLint function(GLhandleARB, const(GLcharARB)*);
	alias fp_glGetActiveUniformARB = void function(GLhandleARB, GLuint,
		GLsizei, GLsizei*, GLint*, GLenum*, GLcharARB*);
	alias fp_glGetUniformfvARB = void function(GLhandleARB, GLint, GLfloat*);
	alias fp_glGetUniformivARB = void function(GLhandleARB, GLint, GLint*);
	alias fp_glGetShaderSourceARB = void function(GLhandleARB, GLsizei, GLsizei*, GLcharARB*);
	alias fp_glShaderStorageBlockBinding = void function(GLuint, GLuint, GLuint);
	alias fp_glGetSubroutineUniformLocation = GLint function(GLuint, GLenum, const(GLchar)*);
	alias fp_glGetSubroutineIndex = GLuint function(GLuint, GLenum, const(GLchar)*);
	alias fp_glGetActiveSubroutineUniformiv = void function(GLuint, GLenum,
		GLuint, GLenum, GLint*);
	alias fp_glGetActiveSubroutineUniformName = void function(GLuint, GLenum,
		GLuint, GLsizei, GLsizei*, GLchar*);
	alias fp_glGetActiveSubroutineName = void function(GLuint, GLenum, GLuint,
		GLsizei, GLsizei*, GLchar*);
	alias fp_glUniformSubroutinesuiv = void function(GLenum, GLsizei, const(GLuint)*);
	alias fp_glGetUniformSubroutineuiv = void function(GLenum, GLint, GLuint*);
	alias fp_glGetProgramStageiv = void function(GLuint, GLenum, GLenum, GLint*);
	alias fp_glNamedStringARB = void function(GLenum, GLint, const(GLchar)*,
		GLint, const(GLchar)*);
	alias fp_glDeleteNamedStringARB = void function(GLint, const(GLchar)*);
	alias fp_glCompileShaderIncludeARB = void function(GLuint, GLsizei,
		const(GLchar*)*, const(GLint)*);
	alias fp_glIsNamedStringARB = GLboolean function(GLint, const(GLchar)*);
	alias fp_glGetNamedStringARB = void function(GLint, const(GLchar)*,
		GLsizei, GLint*, GLchar*);
	alias fp_glGetNamedStringivARB = void function(GLint, const(GLchar)*, GLenum, GLint*);
	alias fp_glBufferPageCommitmentARB = void function(GLenum, GLintptr, GLsizeiptr,
		GLboolean);
	alias fp_glNamedBufferPageCommitmentEXT = void function(GLuint, GLintptr,
		GLsizeiptr, GLboolean);
	alias fp_glNamedBufferPageCommitmentARB = void function(GLuint, GLintptr,
		GLsizeiptr, GLboolean);
	alias fp_glTexPageCommitmentARB = void function(GLenum, GLint, GLint,
		GLint, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glPatchParameteri = void function(GLenum, GLint);
	alias fp_glPatchParameterfv = void function(GLenum, const(GLfloat)*);
	alias fp_glTextureBarrier = void function();
	alias fp_glTexBufferARB = void function(GLenum, GLenum, GLuint);
	alias fp_glTexBufferRange = void function(GLenum, GLenum, GLuint, GLintptr, GLsizeiptr);
	alias fp_glCompressedTexImage3DARB = void function(GLenum, GLint, GLenum,
		GLsizei, GLsizei, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedTexImage2DARB = void function(GLenum, GLint, GLenum,
		GLsizei, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedTexImage1DARB = void function(GLenum, GLint, GLenum,
		GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedTexSubImage3DARB = void function(GLenum, GLint, GLint,
		GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedTexSubImage2DARB = void function(GLenum, GLint, GLint,
		GLint, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedTexSubImage1DARB = void function(GLenum, GLint, GLint,
		GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glGetCompressedTexImageARB = void function(GLenum, GLint, void*);
	alias fp_glTexStorage1D = void function(GLenum, GLsizei, GLenum, GLsizei);
	alias fp_glTexStorage2D = void function(GLenum, GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glTexStorage3D = void function(GLenum, GLsizei, GLenum, GLsizei, GLsizei,
		GLsizei);
	alias fp_glTexStorage2DMultisample = void function(GLenum, GLsizei, GLenum,
		GLsizei, GLsizei, GLboolean);
	alias fp_glTexStorage3DMultisample = void function(GLenum, GLsizei, GLenum,
		GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureView = void function(GLuint, GLenum, GLuint, GLenum,
		GLuint, GLuint, GLuint, GLuint);
	alias fp_glBindTransformFeedback = void function(GLenum, GLuint);
	alias fp_glDeleteTransformFeedbacks = void function(GLsizei, const(GLuint)*);
	alias fp_glGenTransformFeedbacks = void function(GLsizei, GLuint*);
	alias fp_glIsTransformFeedback = GLboolean function(GLuint);
	alias fp_glPauseTransformFeedback = void function();
	alias fp_glResumeTransformFeedback = void function();
	alias fp_glDrawTransformFeedback = void function(GLenum, GLuint);
	alias fp_glDrawTransformFeedbackStream = void function(GLenum, GLuint, GLuint);
	alias fp_glBeginQueryIndexed = void function(GLenum, GLuint, GLuint);
	alias fp_glEndQueryIndexed = void function(GLenum, GLuint);
	alias fp_glGetQueryIndexediv = void function(GLenum, GLuint, GLenum, GLint*);
	alias fp_glDrawTransformFeedbackInstanced = void function(GLenum, GLuint, GLsizei);
	alias fp_glDrawTransformFeedbackStreamInstanced = void function(GLenum, GLuint,
		GLuint, GLsizei);
	alias fp_glLoadTransposeMatrixfARB = void function(const(GLfloat)*);
	alias fp_glLoadTransposeMatrixdARB = void function(const(GLdouble)*);
	alias fp_glMultTransposeMatrixfARB = void function(const(GLfloat)*);
	alias fp_glMultTransposeMatrixdARB = void function(const(GLdouble)*);
	alias fp_glVertexAttribL1d = void function(GLuint, GLdouble);
	alias fp_glVertexAttribL2d = void function(GLuint, GLdouble, GLdouble);
	alias fp_glVertexAttribL3d = void function(GLuint, GLdouble, GLdouble, GLdouble);
	alias fp_glVertexAttribL4d = void function(GLuint, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glVertexAttribL1dv = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribL2dv = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribL3dv = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribL4dv = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribLPointer = void function(GLuint, GLint, GLenum, GLsizei,
		const(void)*);
	alias fp_glGetVertexAttribLdv = void function(GLuint, GLenum, GLdouble*);
	alias fp_glBindVertexBuffer = void function(GLuint, GLuint, GLintptr, GLsizei);
	alias fp_glVertexAttribFormat = void function(GLuint, GLint, GLenum, GLboolean,
		GLuint);
	alias fp_glVertexAttribIFormat = void function(GLuint, GLint, GLenum, GLuint);
	alias fp_glVertexAttribLFormat = void function(GLuint, GLint, GLenum, GLuint);
	alias fp_glVertexAttribBinding = void function(GLuint, GLuint);
	alias fp_glVertexBindingDivisor = void function(GLuint, GLuint);
	alias fp_glWeightbvARB = void function(GLint, const(GLbyte)*);
	alias fp_glWeightsvARB = void function(GLint, const(GLshort)*);
	alias fp_glWeightivARB = void function(GLint, const(GLint)*);
	alias fp_glWeightfvARB = void function(GLint, const(GLfloat)*);
	alias fp_glWeightdvARB = void function(GLint, const(GLdouble)*);
	alias fp_glWeightubvARB = void function(GLint, const(GLubyte)*);
	alias fp_glWeightusvARB = void function(GLint, const(GLushort)*);
	alias fp_glWeightuivARB = void function(GLint, const(GLuint)*);
	alias fp_glWeightPointerARB = void function(GLint, GLenum, GLsizei, const(void)*);
	alias fp_glVertexBlendARB = void function(GLint);
	alias fp_glBindBufferARB = void function(GLenum, GLuint);
	alias fp_glDeleteBuffersARB = void function(GLsizei, const(GLuint)*);
	alias fp_glGenBuffersARB = void function(GLsizei, GLuint*);
	alias fp_glIsBufferARB = GLboolean function(GLuint);
	alias fp_glBufferDataARB = void function(GLenum, GLsizeiptrARB, const(void)*, GLenum);
	alias fp_glBufferSubDataARB = void function(GLenum, GLintptrARB, GLsizeiptrARB,
		const(void)*);
	alias fp_glGetBufferSubDataARB = void function(GLenum, GLintptrARB, GLsizeiptrARB,
		void*);
	alias fp_glMapBufferARB = void* function(GLenum, GLenum);
	alias fp_glUnmapBufferARB = GLboolean function(GLenum);
	alias fp_glGetBufferParameterivARB = void function(GLenum, GLenum, GLint*);
	alias fp_glGetBufferPointervARB = void function(GLenum, GLenum, void**);
	alias fp_glVertexAttrib1dARB = void function(GLuint, GLdouble);
	alias fp_glVertexAttrib1dvARB = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib1fARB = void function(GLuint, GLfloat);
	alias fp_glVertexAttrib1fvARB = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib1sARB = void function(GLuint, GLshort);
	alias fp_glVertexAttrib1svARB = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib2dARB = void function(GLuint, GLdouble, GLdouble);
	alias fp_glVertexAttrib2dvARB = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib2fARB = void function(GLuint, GLfloat, GLfloat);
	alias fp_glVertexAttrib2fvARB = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib2sARB = void function(GLuint, GLshort, GLshort);
	alias fp_glVertexAttrib2svARB = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib3dARB = void function(GLuint, GLdouble, GLdouble, GLdouble);
	alias fp_glVertexAttrib3dvARB = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib3fARB = void function(GLuint, GLfloat, GLfloat, GLfloat);
	alias fp_glVertexAttrib3fvARB = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib3sARB = void function(GLuint, GLshort, GLshort, GLshort);
	alias fp_glVertexAttrib3svARB = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib4NbvARB = void function(GLuint, const(GLbyte)*);
	alias fp_glVertexAttrib4NivARB = void function(GLuint, const(GLint)*);
	alias fp_glVertexAttrib4NsvARB = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib4NubARB = void function(GLuint, GLubyte, GLubyte, GLubyte,
		GLubyte);
	alias fp_glVertexAttrib4NubvARB = void function(GLuint, const(GLubyte)*);
	alias fp_glVertexAttrib4NuivARB = void function(GLuint, const(GLuint)*);
	alias fp_glVertexAttrib4NusvARB = void function(GLuint, const(GLushort)*);
	alias fp_glVertexAttrib4bvARB = void function(GLuint, const(GLbyte)*);
	alias fp_glVertexAttrib4dARB = void function(GLuint, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glVertexAttrib4dvARB = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib4fARB = void function(GLuint, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glVertexAttrib4fvARB = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib4ivARB = void function(GLuint, const(GLint)*);
	alias fp_glVertexAttrib4sARB = void function(GLuint, GLshort, GLshort, GLshort,
		GLshort);
	alias fp_glVertexAttrib4svARB = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib4ubvARB = void function(GLuint, const(GLubyte)*);
	alias fp_glVertexAttrib4uivARB = void function(GLuint, const(GLuint)*);
	alias fp_glVertexAttrib4usvARB = void function(GLuint, const(GLushort)*);
	alias fp_glVertexAttribPointerARB = void function(GLuint, GLint, GLenum,
		GLboolean, GLsizei, const(void)*);
	alias fp_glEnableVertexAttribArrayARB = void function(GLuint);
	alias fp_glDisableVertexAttribArrayARB = void function(GLuint);
	alias fp_glGetVertexAttribdvARB = void function(GLuint, GLenum, GLdouble*);
	alias fp_glGetVertexAttribfvARB = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetVertexAttribivARB = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVertexAttribPointervARB = void function(GLuint, GLenum, void**);
	alias fp_glBindAttribLocationARB = void function(GLhandleARB, GLuint, const(GLcharARB)*);
	alias fp_glGetActiveAttribARB = void function(GLhandleARB, GLuint, GLsizei,
		GLsizei*, GLint*, GLenum*, GLcharARB*);
	alias fp_glGetAttribLocationARB = GLint function(GLhandleARB, const(GLcharARB)*);
	alias fp_glViewportArrayv = void function(GLuint, GLsizei, const(GLfloat)*);
	alias fp_glViewportIndexedf = void function(GLuint, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glViewportIndexedfv = void function(GLuint, const(GLfloat)*);
	alias fp_glScissorArrayv = void function(GLuint, GLsizei, const(GLint)*);
	alias fp_glScissorIndexed = void function(GLuint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glScissorIndexedv = void function(GLuint, const(GLint)*);
	alias fp_glDepthRangeArrayv = void function(GLuint, GLsizei, const(GLdouble)*);
	alias fp_glDepthRangeIndexed = void function(GLuint, GLdouble, GLdouble);
	alias fp_glGetFloati_v = void function(GLenum, GLuint, GLfloat*);
	alias fp_glGetDoublei_v = void function(GLenum, GLuint, GLdouble*);
	alias fp_glWindowPos2dARB = void function(GLdouble, GLdouble);
	alias fp_glWindowPos2dvARB = void function(const(GLdouble)*);
	alias fp_glWindowPos2fARB = void function(GLfloat, GLfloat);
	alias fp_glWindowPos2fvARB = void function(const(GLfloat)*);
	alias fp_glWindowPos2iARB = void function(GLint, GLint);
	alias fp_glWindowPos2ivARB = void function(const(GLint)*);
	alias fp_glWindowPos2sARB = void function(GLshort, GLshort);
	alias fp_glWindowPos2svARB = void function(const(GLshort)*);
	alias fp_glWindowPos3dARB = void function(GLdouble, GLdouble, GLdouble);
	alias fp_glWindowPos3dvARB = void function(const(GLdouble)*);
	alias fp_glWindowPos3fARB = void function(GLfloat, GLfloat, GLfloat);
	alias fp_glWindowPos3fvARB = void function(const(GLfloat)*);
	alias fp_glWindowPos3iARB = void function(GLint, GLint, GLint);
	alias fp_glWindowPos3ivARB = void function(const(GLint)*);
	alias fp_glWindowPos3sARB = void function(GLshort, GLshort, GLshort);
	alias fp_glWindowPos3svARB = void function(const(GLshort)*);
	alias fp_glDrawBuffersATI = void function(GLsizei, const(GLenum)*);
	alias fp_glElementPointerATI = void function(GLenum, const(void)*);
	alias fp_glDrawElementArrayATI = void function(GLenum, GLsizei);
	alias fp_glDrawRangeElementArrayATI = void function(GLenum, GLuint, GLuint, GLsizei);
	alias fp_glTexBumpParameterivATI = void function(GLenum, const(GLint)*);
	alias fp_glTexBumpParameterfvATI = void function(GLenum, const(GLfloat)*);
	alias fp_glGetTexBumpParameterivATI = void function(GLenum, GLint*);
	alias fp_glGetTexBumpParameterfvATI = void function(GLenum, GLfloat*);
	alias fp_glGenFragmentShadersATI = GLuint function(GLuint);
	alias fp_glBindFragmentShaderATI = void function(GLuint);
	alias fp_glDeleteFragmentShaderATI = void function(GLuint);
	alias fp_glBeginFragmentShaderATI = void function();
	alias fp_glEndFragmentShaderATI = void function();
	alias fp_glPassTexCoordATI = void function(GLuint, GLuint, GLenum);
	alias fp_glSampleMapATI = void function(GLuint, GLuint, GLenum);
	alias fp_glColorFragmentOp1ATI = void function(GLenum, GLuint, GLuint,
		GLuint, GLuint, GLuint, GLuint);
	alias fp_glColorFragmentOp2ATI = void function(GLenum, GLuint, GLuint,
		GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
	alias fp_glColorFragmentOp3ATI = void function(GLenum, GLuint, GLuint,
		GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
	alias fp_glAlphaFragmentOp1ATI = void function(GLenum, GLuint, GLuint, GLuint,
		GLuint, GLuint);
	alias fp_glAlphaFragmentOp2ATI = void function(GLenum, GLuint, GLuint,
		GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
	alias fp_glAlphaFragmentOp3ATI = void function(GLenum, GLuint, GLuint,
		GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
	alias fp_glSetFragmentShaderConstantATI = void function(GLuint, const(GLfloat)*);
	alias fp_glMapObjectBufferATI = void* function(GLuint);
	alias fp_glUnmapObjectBufferATI = void function(GLuint);
	alias fp_glPNTrianglesiATI = void function(GLenum, GLint);
	alias fp_glPNTrianglesfATI = void function(GLenum, GLfloat);
	alias fp_glStencilOpSeparateATI = void function(GLenum, GLenum, GLenum, GLenum);
	alias fp_glStencilFuncSeparateATI = void function(GLenum, GLenum, GLint, GLuint);
	alias fp_glNewObjectBufferATI = GLuint function(GLsizei, const(void)*, GLenum);
	alias fp_glIsObjectBufferATI = GLboolean function(GLuint);
	alias fp_glUpdateObjectBufferATI = void function(GLuint, GLuint, GLsizei,
		const(void)*, GLenum);
	alias fp_glGetObjectBufferfvATI = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetObjectBufferivATI = void function(GLuint, GLenum, GLint*);
	alias fp_glFreeObjectBufferATI = void function(GLuint);
	alias fp_glArrayObjectATI = void function(GLenum, GLint, GLenum, GLsizei, GLuint,
		GLuint);
	alias fp_glGetArrayObjectfvATI = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetArrayObjectivATI = void function(GLenum, GLenum, GLint*);
	alias fp_glVariantArrayObjectATI = void function(GLuint, GLenum, GLsizei, GLuint,
		GLuint);
	alias fp_glGetVariantArrayObjectfvATI = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetVariantArrayObjectivATI = void function(GLuint, GLenum, GLint*);
	alias fp_glVertexAttribArrayObjectATI = void function(GLuint, GLint,
		GLenum, GLboolean, GLsizei, GLuint, GLuint);
	alias fp_glGetVertexAttribArrayObjectfvATI = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetVertexAttribArrayObjectivATI = void function(GLuint, GLenum, GLint*);
	alias fp_glVertexStream1sATI = void function(GLenum, GLshort);
	alias fp_glVertexStream1svATI = void function(GLenum, const(GLshort)*);
	alias fp_glVertexStream1iATI = void function(GLenum, GLint);
	alias fp_glVertexStream1ivATI = void function(GLenum, const(GLint)*);
	alias fp_glVertexStream1fATI = void function(GLenum, GLfloat);
	alias fp_glVertexStream1fvATI = void function(GLenum, const(GLfloat)*);
	alias fp_glVertexStream1dATI = void function(GLenum, GLdouble);
	alias fp_glVertexStream1dvATI = void function(GLenum, const(GLdouble)*);
	alias fp_glVertexStream2sATI = void function(GLenum, GLshort, GLshort);
	alias fp_glVertexStream2svATI = void function(GLenum, const(GLshort)*);
	alias fp_glVertexStream2iATI = void function(GLenum, GLint, GLint);
	alias fp_glVertexStream2ivATI = void function(GLenum, const(GLint)*);
	alias fp_glVertexStream2fATI = void function(GLenum, GLfloat, GLfloat);
	alias fp_glVertexStream2fvATI = void function(GLenum, const(GLfloat)*);
	alias fp_glVertexStream2dATI = void function(GLenum, GLdouble, GLdouble);
	alias fp_glVertexStream2dvATI = void function(GLenum, const(GLdouble)*);
	alias fp_glVertexStream3sATI = void function(GLenum, GLshort, GLshort, GLshort);
	alias fp_glVertexStream3svATI = void function(GLenum, const(GLshort)*);
	alias fp_glVertexStream3iATI = void function(GLenum, GLint, GLint, GLint);
	alias fp_glVertexStream3ivATI = void function(GLenum, const(GLint)*);
	alias fp_glVertexStream3fATI = void function(GLenum, GLfloat, GLfloat, GLfloat);
	alias fp_glVertexStream3fvATI = void function(GLenum, const(GLfloat)*);
	alias fp_glVertexStream3dATI = void function(GLenum, GLdouble, GLdouble, GLdouble);
	alias fp_glVertexStream3dvATI = void function(GLenum, const(GLdouble)*);
	alias fp_glVertexStream4sATI = void function(GLenum, GLshort, GLshort, GLshort,
		GLshort);
	alias fp_glVertexStream4svATI = void function(GLenum, const(GLshort)*);
	alias fp_glVertexStream4iATI = void function(GLenum, GLint, GLint, GLint, GLint);
	alias fp_glVertexStream4ivATI = void function(GLenum, const(GLint)*);
	alias fp_glVertexStream4fATI = void function(GLenum, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glVertexStream4fvATI = void function(GLenum, const(GLfloat)*);
	alias fp_glVertexStream4dATI = void function(GLenum, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glVertexStream4dvATI = void function(GLenum, const(GLdouble)*);
	alias fp_glNormalStream3bATI = void function(GLenum, GLbyte, GLbyte, GLbyte);
	alias fp_glNormalStream3bvATI = void function(GLenum, const(GLbyte)*);
	alias fp_glNormalStream3sATI = void function(GLenum, GLshort, GLshort, GLshort);
	alias fp_glNormalStream3svATI = void function(GLenum, const(GLshort)*);
	alias fp_glNormalStream3iATI = void function(GLenum, GLint, GLint, GLint);
	alias fp_glNormalStream3ivATI = void function(GLenum, const(GLint)*);
	alias fp_glNormalStream3fATI = void function(GLenum, GLfloat, GLfloat, GLfloat);
	alias fp_glNormalStream3fvATI = void function(GLenum, const(GLfloat)*);
	alias fp_glNormalStream3dATI = void function(GLenum, GLdouble, GLdouble, GLdouble);
	alias fp_glNormalStream3dvATI = void function(GLenum, const(GLdouble)*);
	alias fp_glClientActiveVertexStreamATI = void function(GLenum);
	alias fp_glVertexBlendEnviATI = void function(GLenum, GLint);
	alias fp_glVertexBlendEnvfATI = void function(GLenum, GLfloat);
	alias fp_glUniformBufferEXT = void function(GLuint, GLint, GLuint);
	alias fp_glGetUniformBufferSizeEXT = GLint function(GLuint, GLint);
	alias fp_glGetUniformOffsetEXT = GLintptr function(GLuint, GLint);
	alias fp_glBlendColorEXT = void function(GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glBlendEquationSeparateEXT = void function(GLenum, GLenum);
	alias fp_glBlendFuncSeparateEXT = void function(GLenum, GLenum, GLenum, GLenum);
	alias fp_glBlendEquationEXT = void function(GLenum);
	alias fp_glColorSubTableEXT = void function(GLenum, GLsizei, GLsizei,
		GLenum, GLenum, const(void)*);
	alias fp_glCopyColorSubTableEXT = void function(GLenum, GLsizei, GLint, GLint,
		GLsizei);
	alias fp_glLockArraysEXT = void function(GLint, GLsizei);
	alias fp_glUnlockArraysEXT = void function();
	alias fp_glConvolutionFilter1DEXT = void function(GLenum, GLenum, GLsizei,
		GLenum, GLenum, const(void)*);
	alias fp_glConvolutionFilter2DEXT = void function(GLenum, GLenum, GLsizei,
		GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glConvolutionParameterfEXT = void function(GLenum, GLenum, GLfloat);
	alias fp_glConvolutionParameterfvEXT = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glConvolutionParameteriEXT = void function(GLenum, GLenum, GLint);
	alias fp_glConvolutionParameterivEXT = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glCopyConvolutionFilter1DEXT = void function(GLenum, GLenum, GLint, GLint,
		GLsizei);
	alias fp_glCopyConvolutionFilter2DEXT = void function(GLenum, GLenum,
		GLint, GLint, GLsizei, GLsizei);
	alias fp_glGetConvolutionFilterEXT = void function(GLenum, GLenum, GLenum, void*);
	alias fp_glGetConvolutionParameterfvEXT = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetConvolutionParameterivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glGetSeparableFilterEXT = void function(GLenum, GLenum, GLenum,
		void*, void*, void*);
	alias fp_glSeparableFilter2DEXT = void function(GLenum, GLenum, GLsizei,
		GLsizei, GLenum, GLenum, const(void)*, const(void)*);
	alias fp_glTangent3bEXT = void function(GLbyte, GLbyte, GLbyte);
	alias fp_glTangent3bvEXT = void function(const(GLbyte)*);
	alias fp_glTangent3dEXT = void function(GLdouble, GLdouble, GLdouble);
	alias fp_glTangent3dvEXT = void function(const(GLdouble)*);
	alias fp_glTangent3fEXT = void function(GLfloat, GLfloat, GLfloat);
	alias fp_glTangent3fvEXT = void function(const(GLfloat)*);
	alias fp_glTangent3iEXT = void function(GLint, GLint, GLint);
	alias fp_glTangent3ivEXT = void function(const(GLint)*);
	alias fp_glTangent3sEXT = void function(GLshort, GLshort, GLshort);
	alias fp_glTangent3svEXT = void function(const(GLshort)*);
	alias fp_glBinormal3bEXT = void function(GLbyte, GLbyte, GLbyte);
	alias fp_glBinormal3bvEXT = void function(const(GLbyte)*);
	alias fp_glBinormal3dEXT = void function(GLdouble, GLdouble, GLdouble);
	alias fp_glBinormal3dvEXT = void function(const(GLdouble)*);
	alias fp_glBinormal3fEXT = void function(GLfloat, GLfloat, GLfloat);
	alias fp_glBinormal3fvEXT = void function(const(GLfloat)*);
	alias fp_glBinormal3iEXT = void function(GLint, GLint, GLint);
	alias fp_glBinormal3ivEXT = void function(const(GLint)*);
	alias fp_glBinormal3sEXT = void function(GLshort, GLshort, GLshort);
	alias fp_glBinormal3svEXT = void function(const(GLshort)*);
	alias fp_glTangentPointerEXT = void function(GLenum, GLsizei, const(void)*);
	alias fp_glBinormalPointerEXT = void function(GLenum, GLsizei, const(void)*);
	alias fp_glCopyTexImage1DEXT = void function(GLenum, GLint, GLenum, GLint,
		GLint, GLsizei, GLint);
	alias fp_glCopyTexImage2DEXT = void function(GLenum, GLint, GLenum, GLint,
		GLint, GLsizei, GLsizei, GLint);
	alias fp_glCopyTexSubImage1DEXT = void function(GLenum, GLint, GLint, GLint, GLint,
		GLsizei);
	alias fp_glCopyTexSubImage2DEXT = void function(GLenum, GLint, GLint,
		GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glCopyTexSubImage3DEXT = void function(GLenum, GLint, GLint,
		GLint, GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glCullParameterdvEXT = void function(GLenum, GLdouble*);
	alias fp_glCullParameterfvEXT = void function(GLenum, GLfloat*);
	alias fp_glLabelObjectEXT = void function(GLenum, GLuint, GLsizei, const(GLchar)*);
	alias fp_glGetObjectLabelEXT = void function(GLenum, GLuint, GLsizei, GLsizei*,
		GLchar*);
	alias fp_glInsertEventMarkerEXT = void function(GLsizei, const(GLchar)*);
	alias fp_glPushGroupMarkerEXT = void function(GLsizei, const(GLchar)*);
	alias fp_glPopGroupMarkerEXT = void function();
	alias fp_glDepthBoundsEXT = void function(GLclampd, GLclampd);
	alias fp_glMatrixLoadfEXT = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixLoaddEXT = void function(GLenum, const(GLdouble)*);
	alias fp_glMatrixMultfEXT = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixMultdEXT = void function(GLenum, const(GLdouble)*);
	alias fp_glMatrixLoadIdentityEXT = void function(GLenum);
	alias fp_glMatrixRotatefEXT = void function(GLenum, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glMatrixRotatedEXT = void function(GLenum, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glMatrixScalefEXT = void function(GLenum, GLfloat, GLfloat, GLfloat);
	alias fp_glMatrixScaledEXT = void function(GLenum, GLdouble, GLdouble, GLdouble);
	alias fp_glMatrixTranslatefEXT = void function(GLenum, GLfloat, GLfloat, GLfloat);
	alias fp_glMatrixTranslatedEXT = void function(GLenum, GLdouble, GLdouble, GLdouble);
	alias fp_glMatrixFrustumEXT = void function(GLenum, GLdouble, GLdouble,
		GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glMatrixOrthoEXT = void function(GLenum, GLdouble, GLdouble,
		GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glMatrixPopEXT = void function(GLenum);
	alias fp_glMatrixPushEXT = void function(GLenum);
	alias fp_glClientAttribDefaultEXT = void function(GLbitfield);
	alias fp_glPushClientAttribDefaultEXT = void function(GLbitfield);
	alias fp_glTextureParameterfEXT = void function(GLuint, GLenum, GLenum, GLfloat);
	alias fp_glTextureParameterfvEXT = void function(GLuint, GLenum, GLenum, const(GLfloat)*);
	alias fp_glTextureParameteriEXT = void function(GLuint, GLenum, GLenum, GLint);
	alias fp_glTextureParameterivEXT = void function(GLuint, GLenum, GLenum, const(GLint)*);
	alias fp_glTextureImage1DEXT = void function(GLuint, GLenum, GLint, GLint,
		GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glTextureImage2DEXT = void function(GLuint, GLenum, GLint, GLint,
		GLsizei, GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glTextureSubImage1DEXT = void function(GLuint, GLenum, GLint,
		GLint, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glTextureSubImage2DEXT = void function(GLuint, GLenum, GLint,
		GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glCopyTextureImage1DEXT = void function(GLuint, GLenum, GLint,
		GLenum, GLint, GLint, GLsizei, GLint);
	alias fp_glCopyTextureImage2DEXT = void function(GLuint, GLenum, GLint,
		GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
	alias fp_glCopyTextureSubImage1DEXT = void function(GLuint, GLenum, GLint,
		GLint, GLint, GLint, GLsizei);
	alias fp_glCopyTextureSubImage2DEXT = void function(GLuint, GLenum, GLint,
		GLint, GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glGetTextureImageEXT = void function(GLuint, GLenum, GLint, GLenum, GLenum,
		void*);
	alias fp_glGetTextureParameterfvEXT = void function(GLuint, GLenum, GLenum, GLfloat*);
	alias fp_glGetTextureParameterivEXT = void function(GLuint, GLenum, GLenum, GLint*);
	alias fp_glGetTextureLevelParameterfvEXT = void function(GLuint, GLenum,
		GLint, GLenum, GLfloat*);
	alias fp_glGetTextureLevelParameterivEXT = void function(GLuint, GLenum,
		GLint, GLenum, GLint*);
	alias fp_glTextureImage3DEXT = void function(GLuint, GLenum, GLint, GLint,
		GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glTextureSubImage3DEXT = void function(GLuint, GLenum, GLint,
		GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glCopyTextureSubImage3DEXT = void function(GLuint, GLenum, GLint,
		GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glBindMultiTextureEXT = void function(GLenum, GLenum, GLuint);
	alias fp_glMultiTexCoordPointerEXT = void function(GLenum, GLint, GLenum,
		GLsizei, const(void)*);
	alias fp_glMultiTexEnvfEXT = void function(GLenum, GLenum, GLenum, GLfloat);
	alias fp_glMultiTexEnvfvEXT = void function(GLenum, GLenum, GLenum, const(GLfloat)*);
	alias fp_glMultiTexEnviEXT = void function(GLenum, GLenum, GLenum, GLint);
	alias fp_glMultiTexEnvivEXT = void function(GLenum, GLenum, GLenum, const(GLint)*);
	alias fp_glMultiTexGendEXT = void function(GLenum, GLenum, GLenum, GLdouble);
	alias fp_glMultiTexGendvEXT = void function(GLenum, GLenum, GLenum, const(GLdouble)*);
	alias fp_glMultiTexGenfEXT = void function(GLenum, GLenum, GLenum, GLfloat);
	alias fp_glMultiTexGenfvEXT = void function(GLenum, GLenum, GLenum, const(GLfloat)*);
	alias fp_glMultiTexGeniEXT = void function(GLenum, GLenum, GLenum, GLint);
	alias fp_glMultiTexGenivEXT = void function(GLenum, GLenum, GLenum, const(GLint)*);
	alias fp_glGetMultiTexEnvfvEXT = void function(GLenum, GLenum, GLenum, GLfloat*);
	alias fp_glGetMultiTexEnvivEXT = void function(GLenum, GLenum, GLenum, GLint*);
	alias fp_glGetMultiTexGendvEXT = void function(GLenum, GLenum, GLenum, GLdouble*);
	alias fp_glGetMultiTexGenfvEXT = void function(GLenum, GLenum, GLenum, GLfloat*);
	alias fp_glGetMultiTexGenivEXT = void function(GLenum, GLenum, GLenum, GLint*);
	alias fp_glMultiTexParameteriEXT = void function(GLenum, GLenum, GLenum, GLint);
	alias fp_glMultiTexParameterivEXT = void function(GLenum, GLenum, GLenum, const(GLint)*);
	alias fp_glMultiTexParameterfEXT = void function(GLenum, GLenum, GLenum, GLfloat);
	alias fp_glMultiTexParameterfvEXT = void function(GLenum, GLenum, GLenum, const(GLfloat)*);
	alias fp_glMultiTexImage1DEXT = void function(GLenum, GLenum, GLint, GLint,
		GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glMultiTexImage2DEXT = void function(GLenum, GLenum, GLint, GLint,
		GLsizei, GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glMultiTexSubImage1DEXT = void function(GLenum, GLenum, GLint,
		GLint, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glMultiTexSubImage2DEXT = void function(GLenum, GLenum, GLint,
		GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glCopyMultiTexImage1DEXT = void function(GLenum, GLenum, GLint,
		GLenum, GLint, GLint, GLsizei, GLint);
	alias fp_glCopyMultiTexImage2DEXT = void function(GLenum, GLenum, GLint,
		GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
	alias fp_glCopyMultiTexSubImage1DEXT = void function(GLenum, GLenum, GLint,
		GLint, GLint, GLint, GLsizei);
	alias fp_glCopyMultiTexSubImage2DEXT = void function(GLenum, GLenum, GLint,
		GLint, GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glGetMultiTexImageEXT = void function(GLenum, GLenum, GLint, GLenum, GLenum,
		void*);
	alias fp_glGetMultiTexParameterfvEXT = void function(GLenum, GLenum, GLenum, GLfloat*);
	alias fp_glGetMultiTexParameterivEXT = void function(GLenum, GLenum, GLenum, GLint*);
	alias fp_glGetMultiTexLevelParameterfvEXT = void function(GLenum, GLenum,
		GLint, GLenum, GLfloat*);
	alias fp_glGetMultiTexLevelParameterivEXT = void function(GLenum, GLenum,
		GLint, GLenum, GLint*);
	alias fp_glMultiTexImage3DEXT = void function(GLenum, GLenum, GLint, GLint,
		GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glMultiTexSubImage3DEXT = void function(GLenum, GLenum, GLint,
		GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glCopyMultiTexSubImage3DEXT = void function(GLenum, GLenum, GLint,
		GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
	alias fp_glEnableClientStateIndexedEXT = void function(GLenum, GLuint);
	alias fp_glDisableClientStateIndexedEXT = void function(GLenum, GLuint);
	alias fp_glGetFloatIndexedvEXT = void function(GLenum, GLuint, GLfloat*);
	alias fp_glGetDoubleIndexedvEXT = void function(GLenum, GLuint, GLdouble*);
	alias fp_glGetPointerIndexedvEXT = void function(GLenum, GLuint, void**);
	alias fp_glEnableIndexedEXT = void function(GLenum, GLuint);
	alias fp_glDisableIndexedEXT = void function(GLenum, GLuint);
	alias fp_glIsEnabledIndexedEXT = GLboolean function(GLenum, GLuint);
	alias fp_glGetIntegerIndexedvEXT = void function(GLenum, GLuint, GLint*);
	alias fp_glGetBooleanIndexedvEXT = void function(GLenum, GLuint, GLboolean*);
	alias fp_glCompressedTextureImage3DEXT = void function(GLuint, GLenum,
		GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedTextureImage2DEXT = void function(GLuint, GLenum,
		GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedTextureImage1DEXT = void function(GLuint, GLenum,
		GLint, GLenum, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedTextureSubImage3DEXT = void function(GLuint, GLenum,
		GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedTextureSubImage2DEXT = void function(GLuint, GLenum,
		GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedTextureSubImage1DEXT = void function(GLuint, GLenum,
		GLint, GLint, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glGetCompressedTextureImageEXT = void function(GLuint, GLenum, GLint,
		void*);
	alias fp_glCompressedMultiTexImage3DEXT = void function(GLenum, GLenum,
		GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedMultiTexImage2DEXT = void function(GLenum, GLenum,
		GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedMultiTexImage1DEXT = void function(GLenum, GLenum,
		GLint, GLenum, GLsizei, GLint, GLsizei, const(void)*);
	alias fp_glCompressedMultiTexSubImage3DEXT = void function(GLenum, GLenum,
		GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedMultiTexSubImage2DEXT = void function(GLenum, GLenum,
		GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glCompressedMultiTexSubImage1DEXT = void function(GLenum, GLenum,
		GLint, GLint, GLsizei, GLenum, GLsizei, const(void)*);
	alias fp_glGetCompressedMultiTexImageEXT = void function(GLenum, GLenum, GLint,
		void*);
	alias fp_glMatrixLoadTransposefEXT = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixLoadTransposedEXT = void function(GLenum, const(GLdouble)*);
	alias fp_glMatrixMultTransposefEXT = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixMultTransposedEXT = void function(GLenum, const(GLdouble)*);
	alias fp_glNamedBufferDataEXT = void function(GLuint, GLsizeiptr, const(void)*,
		GLenum);
	alias fp_glNamedBufferSubDataEXT = void function(GLuint, GLintptr, GLsizeiptr,
		const(void)*);
	alias fp_glMapNamedBufferEXT = void* function(GLuint, GLenum);
	alias fp_glUnmapNamedBufferEXT = GLboolean function(GLuint);
	alias fp_glGetNamedBufferParameterivEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glGetNamedBufferPointervEXT = void function(GLuint, GLenum, void**);
	alias fp_glGetNamedBufferSubDataEXT = void function(GLuint, GLintptr, GLsizeiptr,
		void*);
	alias fp_glProgramUniform1fEXT = void function(GLuint, GLint, GLfloat);
	alias fp_glProgramUniform2fEXT = void function(GLuint, GLint, GLfloat, GLfloat);
	alias fp_glProgramUniform3fEXT = void function(GLuint, GLint, GLfloat, GLfloat,
		GLfloat);
	alias fp_glProgramUniform4fEXT = void function(GLuint, GLint, GLfloat,
		GLfloat, GLfloat, GLfloat);
	alias fp_glProgramUniform1iEXT = void function(GLuint, GLint, GLint);
	alias fp_glProgramUniform2iEXT = void function(GLuint, GLint, GLint, GLint);
	alias fp_glProgramUniform3iEXT = void function(GLuint, GLint, GLint, GLint, GLint);
	alias fp_glProgramUniform4iEXT = void function(GLuint, GLint, GLint, GLint, GLint,
		GLint);
	alias fp_glProgramUniform1fvEXT = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform2fvEXT = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform3fvEXT = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform4fvEXT = void function(GLuint, GLint, GLsizei, const(GLfloat)*);
	alias fp_glProgramUniform1ivEXT = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform2ivEXT = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform3ivEXT = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniform4ivEXT = void function(GLuint, GLint, GLsizei, const(GLint)*);
	alias fp_glProgramUniformMatrix2fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix3fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix4fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix2x3fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix3x2fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix2x4fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix4x2fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix3x4fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glProgramUniformMatrix4x3fvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLfloat)*);
	alias fp_glTextureBufferEXT = void function(GLuint, GLenum, GLenum, GLuint);
	alias fp_glMultiTexBufferEXT = void function(GLenum, GLenum, GLenum, GLuint);
	alias fp_glTextureParameterIivEXT = void function(GLuint, GLenum, GLenum, const(GLint)*);
	alias fp_glTextureParameterIuivEXT = void function(GLuint, GLenum, GLenum, const(GLuint)*);
	alias fp_glGetTextureParameterIivEXT = void function(GLuint, GLenum, GLenum, GLint*);
	alias fp_glGetTextureParameterIuivEXT = void function(GLuint, GLenum, GLenum, GLuint*);
	alias fp_glMultiTexParameterIivEXT = void function(GLenum, GLenum, GLenum, const(GLint)*);
	alias fp_glMultiTexParameterIuivEXT = void function(GLenum, GLenum, GLenum, const(GLuint)*);
	alias fp_glGetMultiTexParameterIivEXT = void function(GLenum, GLenum, GLenum, GLint*);
	alias fp_glGetMultiTexParameterIuivEXT = void function(GLenum, GLenum, GLenum,
		GLuint*);
	alias fp_glProgramUniform1uiEXT = void function(GLuint, GLint, GLuint);
	alias fp_glProgramUniform2uiEXT = void function(GLuint, GLint, GLuint, GLuint);
	alias fp_glProgramUniform3uiEXT = void function(GLuint, GLint, GLuint, GLuint,
		GLuint);
	alias fp_glProgramUniform4uiEXT = void function(GLuint, GLint, GLuint, GLuint,
		GLuint, GLuint);
	alias fp_glProgramUniform1uivEXT = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniform2uivEXT = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniform3uivEXT = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glProgramUniform4uivEXT = void function(GLuint, GLint, GLsizei, const(GLuint)*);
	alias fp_glNamedProgramLocalParameters4fvEXT = void function(GLuint,
		GLenum, GLuint, GLsizei, const(GLfloat)*);
	alias fp_glNamedProgramLocalParameterI4iEXT = void function(GLuint, GLenum,
		GLuint, GLint, GLint, GLint, GLint);
	alias fp_glNamedProgramLocalParameterI4ivEXT = void function(GLuint,
		GLenum, GLuint, const(GLint)*);
	alias fp_glNamedProgramLocalParametersI4ivEXT = void function(GLuint,
		GLenum, GLuint, GLsizei, const(GLint)*);
	alias fp_glNamedProgramLocalParameterI4uiEXT = void function(GLuint,
		GLenum, GLuint, GLuint, GLuint, GLuint, GLuint);
	alias fp_glNamedProgramLocalParameterI4uivEXT = void function(GLuint,
		GLenum, GLuint, const(GLuint)*);
	alias fp_glNamedProgramLocalParametersI4uivEXT = void function(GLuint,
		GLenum, GLuint, GLsizei, const(GLuint)*);
	alias fp_glGetNamedProgramLocalParameterIivEXT = void function(GLuint, GLenum,
		GLuint, GLint*);
	alias fp_glGetNamedProgramLocalParameterIuivEXT = void function(GLuint,
		GLenum, GLuint, GLuint*);
	alias fp_glEnableClientStateiEXT = void function(GLenum, GLuint);
	alias fp_glDisableClientStateiEXT = void function(GLenum, GLuint);
	alias fp_glGetFloati_vEXT = void function(GLenum, GLuint, GLfloat*);
	alias fp_glGetDoublei_vEXT = void function(GLenum, GLuint, GLdouble*);
	alias fp_glGetPointeri_vEXT = void function(GLenum, GLuint, void**);
	alias fp_glNamedProgramStringEXT = void function(GLuint, GLenum, GLenum,
		GLsizei, const(void)*);
	alias fp_glNamedProgramLocalParameter4dEXT = void function(GLuint, GLenum,
		GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glNamedProgramLocalParameter4dvEXT = void function(GLuint, GLenum,
		GLuint, const(GLdouble)*);
	alias fp_glNamedProgramLocalParameter4fEXT = void function(GLuint, GLenum,
		GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glNamedProgramLocalParameter4fvEXT = void function(GLuint, GLenum,
		GLuint, const(GLfloat)*);
	alias fp_glGetNamedProgramLocalParameterdvEXT = void function(GLuint,
		GLenum, GLuint, GLdouble*);
	alias fp_glGetNamedProgramLocalParameterfvEXT = void function(GLuint, GLenum, GLuint,
		GLfloat*);
	alias fp_glGetNamedProgramivEXT = void function(GLuint, GLenum, GLenum, GLint*);
	alias fp_glGetNamedProgramStringEXT = void function(GLuint, GLenum, GLenum, void*);
	alias fp_glNamedRenderbufferStorageEXT = void function(GLuint, GLenum, GLsizei,
		GLsizei);
	alias fp_glGetNamedRenderbufferParameterivEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glNamedRenderbufferStorageMultisampleEXT = void function(GLuint,
		GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glNamedRenderbufferStorageMultisampleCoverageEXT = void function(GLuint,
		GLsizei, GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glCheckNamedFramebufferStatusEXT = GLenum function(GLuint, GLenum);
	alias fp_glNamedFramebufferTexture1DEXT = void function(GLuint, GLenum, GLenum,
		GLuint, GLint);
	alias fp_glNamedFramebufferTexture2DEXT = void function(GLuint, GLenum, GLenum,
		GLuint, GLint);
	alias fp_glNamedFramebufferTexture3DEXT = void function(GLuint, GLenum,
		GLenum, GLuint, GLint, GLint);
	alias fp_glNamedFramebufferRenderbufferEXT = void function(GLuint, GLenum, GLenum,
		GLuint);
	alias fp_glGetNamedFramebufferAttachmentParameterivEXT = void function(GLuint,
		GLenum, GLenum, GLint*);
	alias fp_glGenerateTextureMipmapEXT = void function(GLuint, GLenum);
	alias fp_glGenerateMultiTexMipmapEXT = void function(GLenum, GLenum);
	alias fp_glFramebufferDrawBufferEXT = void function(GLuint, GLenum);
	alias fp_glFramebufferDrawBuffersEXT = void function(GLuint, GLsizei, const(GLenum)*);
	alias fp_glFramebufferReadBufferEXT = void function(GLuint, GLenum);
	alias fp_glGetFramebufferParameterivEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glNamedCopyBufferSubDataEXT = void function(GLuint, GLuint,
		GLintptr, GLintptr, GLsizeiptr);
	alias fp_glNamedFramebufferTextureEXT = void function(GLuint, GLenum, GLuint, GLint);
	alias fp_glNamedFramebufferTextureLayerEXT = void function(GLuint, GLenum, GLuint,
		GLint, GLint);
	alias fp_glNamedFramebufferTextureFaceEXT = void function(GLuint, GLenum,
		GLuint, GLint, GLenum);
	alias fp_glTextureRenderbufferEXT = void function(GLuint, GLenum, GLuint);
	alias fp_glMultiTexRenderbufferEXT = void function(GLenum, GLenum, GLuint);
	alias fp_glVertexArrayVertexOffsetEXT = void function(GLuint, GLuint,
		GLint, GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayColorOffsetEXT = void function(GLuint, GLuint, GLint,
		GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayEdgeFlagOffsetEXT = void function(GLuint, GLuint, GLsizei,
		GLintptr);
	alias fp_glVertexArrayIndexOffsetEXT = void function(GLuint, GLuint,
		GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayNormalOffsetEXT = void function(GLuint, GLuint,
		GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayTexCoordOffsetEXT = void function(GLuint, GLuint,
		GLint, GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayMultiTexCoordOffsetEXT = void function(GLuint,
		GLuint, GLenum, GLint, GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayFogCoordOffsetEXT = void function(GLuint, GLuint,
		GLenum, GLsizei, GLintptr);
	alias fp_glVertexArraySecondaryColorOffsetEXT = void function(GLuint,
		GLuint, GLint, GLenum, GLsizei, GLintptr);
	alias fp_glVertexArrayVertexAttribOffsetEXT = void function(GLuint, GLuint,
		GLuint, GLint, GLenum, GLboolean, GLsizei, GLintptr);
	alias fp_glVertexArrayVertexAttribIOffsetEXT = void function(GLuint,
		GLuint, GLuint, GLint, GLenum, GLsizei, GLintptr);
	alias fp_glEnableVertexArrayEXT = void function(GLuint, GLenum);
	alias fp_glDisableVertexArrayEXT = void function(GLuint, GLenum);
	alias fp_glEnableVertexArrayAttribEXT = void function(GLuint, GLuint);
	alias fp_glDisableVertexArrayAttribEXT = void function(GLuint, GLuint);
	alias fp_glGetVertexArrayIntegervEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVertexArrayPointervEXT = void function(GLuint, GLenum, void**);
	alias fp_glGetVertexArrayIntegeri_vEXT = void function(GLuint, GLuint, GLenum,
		GLint*);
	alias fp_glGetVertexArrayPointeri_vEXT = void function(GLuint, GLuint, GLenum,
		void**);
	alias fp_glMapNamedBufferRangeEXT = void* function(GLuint, GLintptr, GLsizeiptr,
		GLbitfield);
	alias fp_glFlushMappedNamedBufferRangeEXT = void function(GLuint, GLintptr, GLsizeiptr);
	alias fp_glNamedBufferStorageEXT = void function(GLuint, GLsizeiptr,
		const(void)*, GLbitfield);
	alias fp_glClearNamedBufferDataEXT = void function(GLuint, GLenum, GLenum,
		GLenum, const(void)*);
	alias fp_glClearNamedBufferSubDataEXT = void function(GLuint, GLenum,
		GLsizeiptr, GLsizeiptr, GLenum, GLenum, const(void)*);
	alias fp_glNamedFramebufferParameteriEXT = void function(GLuint, GLenum, GLint);
	alias fp_glGetNamedFramebufferParameterivEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glProgramUniform1dEXT = void function(GLuint, GLint, GLdouble);
	alias fp_glProgramUniform2dEXT = void function(GLuint, GLint, GLdouble, GLdouble);
	alias fp_glProgramUniform3dEXT = void function(GLuint, GLint, GLdouble, GLdouble,
		GLdouble);
	alias fp_glProgramUniform4dEXT = void function(GLuint, GLint, GLdouble,
		GLdouble, GLdouble, GLdouble);
	alias fp_glProgramUniform1dvEXT = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform2dvEXT = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform3dvEXT = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniform4dvEXT = void function(GLuint, GLint, GLsizei, const(GLdouble)*);
	alias fp_glProgramUniformMatrix2dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix3dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix4dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix2x3dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix2x4dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix3x2dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix3x4dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix4x2dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glProgramUniformMatrix4x3dvEXT = void function(GLuint, GLint,
		GLsizei, GLboolean, const(GLdouble)*);
	alias fp_glTextureBufferRangeEXT = void function(GLuint, GLenum, GLenum,
		GLuint, GLintptr, GLsizeiptr);
	alias fp_glTextureStorage1DEXT = void function(GLuint, GLenum, GLsizei, GLenum,
		GLsizei);
	alias fp_glTextureStorage2DEXT = void function(GLuint, GLenum, GLsizei,
		GLenum, GLsizei, GLsizei);
	alias fp_glTextureStorage3DEXT = void function(GLuint, GLenum, GLsizei,
		GLenum, GLsizei, GLsizei, GLsizei);
	alias fp_glTextureStorage2DMultisampleEXT = void function(GLuint, GLenum,
		GLsizei, GLenum, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureStorage3DMultisampleEXT = void function(GLuint, GLenum,
		GLsizei, GLenum, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glVertexArrayBindVertexBufferEXT = void function(GLuint, GLuint,
		GLuint, GLintptr, GLsizei);
	alias fp_glVertexArrayVertexAttribFormatEXT = void function(GLuint, GLuint,
		GLint, GLenum, GLboolean, GLuint);
	alias fp_glVertexArrayVertexAttribIFormatEXT = void function(GLuint,
		GLuint, GLint, GLenum, GLuint);
	alias fp_glVertexArrayVertexAttribLFormatEXT = void function(GLuint,
		GLuint, GLint, GLenum, GLuint);
	alias fp_glVertexArrayVertexAttribBindingEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glVertexArrayVertexBindingDivisorEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glVertexArrayVertexAttribLOffsetEXT = void function(GLuint,
		GLuint, GLuint, GLint, GLenum, GLsizei, GLintptr);
	alias fp_glTexturePageCommitmentEXT = void function(GLuint, GLint, GLint,
		GLint, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glVertexArrayVertexAttribDivisorEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glColorMaskIndexedEXT = void function(GLuint, GLboolean,
		GLboolean, GLboolean, GLboolean);
	alias fp_glDrawArraysInstancedEXT = void function(GLenum, GLint, GLsizei, GLsizei);
	alias fp_glDrawElementsInstancedEXT = void function(GLenum, GLsizei,
		GLenum, const(void)*, GLsizei);
	alias fp_glDrawRangeElementsEXT = void function(GLenum, GLuint, GLuint,
		GLsizei, GLenum, const(void)*);
	alias fp_glFogCoordfEXT = void function(GLfloat);
	alias fp_glFogCoordfvEXT = void function(const(GLfloat)*);
	alias fp_glFogCoorddEXT = void function(GLdouble);
	alias fp_glFogCoorddvEXT = void function(const(GLdouble)*);
	alias fp_glFogCoordPointerEXT = void function(GLenum, GLsizei, const(void)*);
	alias fp_glBlitFramebufferEXT = void function(GLint, GLint, GLint, GLint,
		GLint, GLint, GLint, GLint, GLbitfield, GLenum);
	alias fp_glRenderbufferStorageMultisampleEXT = void function(GLenum,
		GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glIsRenderbufferEXT = GLboolean function(GLuint);
	alias fp_glBindRenderbufferEXT = void function(GLenum, GLuint);
	alias fp_glDeleteRenderbuffersEXT = void function(GLsizei, const(GLuint)*);
	alias fp_glGenRenderbuffersEXT = void function(GLsizei, GLuint*);
	alias fp_glRenderbufferStorageEXT = void function(GLenum, GLenum, GLsizei, GLsizei);
	alias fp_glGetRenderbufferParameterivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glIsFramebufferEXT = GLboolean function(GLuint);
	alias fp_glBindFramebufferEXT = void function(GLenum, GLuint);
	alias fp_glDeleteFramebuffersEXT = void function(GLsizei, const(GLuint)*);
	alias fp_glGenFramebuffersEXT = void function(GLsizei, GLuint*);
	alias fp_glCheckFramebufferStatusEXT = GLenum function(GLenum);
	alias fp_glFramebufferTexture1DEXT = void function(GLenum, GLenum, GLenum, GLuint,
		GLint);
	alias fp_glFramebufferTexture2DEXT = void function(GLenum, GLenum, GLenum, GLuint,
		GLint);
	alias fp_glFramebufferTexture3DEXT = void function(GLenum, GLenum,
		GLenum, GLuint, GLint, GLint);
	alias fp_glFramebufferRenderbufferEXT = void function(GLenum, GLenum, GLenum, GLuint);
	alias fp_glGetFramebufferAttachmentParameterivEXT = void function(GLenum,
		GLenum, GLenum, GLint*);
	alias fp_glGenerateMipmapEXT = void function(GLenum);
	alias fp_glProgramParameteriEXT = void function(GLuint, GLenum, GLint);
	alias fp_glProgramEnvParameters4fvEXT = void function(GLenum, GLuint,
		GLsizei, const(GLfloat)*);
	alias fp_glProgramLocalParameters4fvEXT = void function(GLenum, GLuint,
		GLsizei, const(GLfloat)*);
	alias fp_glGetUniformuivEXT = void function(GLuint, GLint, GLuint*);
	alias fp_glBindFragDataLocationEXT = void function(GLuint, GLuint, const(GLchar)*);
	alias fp_glGetFragDataLocationEXT = GLint function(GLuint, const(GLchar)*);
	alias fp_glUniform1uiEXT = void function(GLint, GLuint);
	alias fp_glUniform2uiEXT = void function(GLint, GLuint, GLuint);
	alias fp_glUniform3uiEXT = void function(GLint, GLuint, GLuint, GLuint);
	alias fp_glUniform4uiEXT = void function(GLint, GLuint, GLuint, GLuint, GLuint);
	alias fp_glUniform1uivEXT = void function(GLint, GLsizei, const(GLuint)*);
	alias fp_glUniform2uivEXT = void function(GLint, GLsizei, const(GLuint)*);
	alias fp_glUniform3uivEXT = void function(GLint, GLsizei, const(GLuint)*);
	alias fp_glUniform4uivEXT = void function(GLint, GLsizei, const(GLuint)*);
	alias fp_glGetHistogramEXT = void function(GLenum, GLboolean, GLenum, GLenum, void*);
	alias fp_glGetHistogramParameterfvEXT = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetHistogramParameterivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glGetMinmaxEXT = void function(GLenum, GLboolean, GLenum, GLenum, void*);
	alias fp_glGetMinmaxParameterfvEXT = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetMinmaxParameterivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glHistogramEXT = void function(GLenum, GLsizei, GLenum, GLboolean);
	alias fp_glMinmaxEXT = void function(GLenum, GLenum, GLboolean);
	alias fp_glResetHistogramEXT = void function(GLenum);
	alias fp_glResetMinmaxEXT = void function(GLenum);
	alias fp_glIndexFuncEXT = void function(GLenum, GLclampf);
	alias fp_glIndexMaterialEXT = void function(GLenum, GLenum);
	alias fp_glApplyTextureEXT = void function(GLenum);
	alias fp_glTextureLightEXT = void function(GLenum);
	alias fp_glTextureMaterialEXT = void function(GLenum, GLenum);
	alias fp_glMultiDrawArraysEXT = void function(GLenum, const(GLint)*,
		const(GLsizei)*, GLsizei);
	alias fp_glMultiDrawElementsEXT = void function(GLenum, const(GLsizei)*,
		GLenum, const(void*)*, GLsizei);
	alias fp_glSampleMaskEXT = void function(GLclampf, GLboolean);
	alias fp_glSamplePatternEXT = void function(GLenum);
	alias fp_glColorTableEXT = void function(GLenum, GLenum, GLsizei, GLenum,
		GLenum, const(void)*);
	alias fp_glGetColorTableEXT = void function(GLenum, GLenum, GLenum, void*);
	alias fp_glGetColorTableParameterivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glGetColorTableParameterfvEXT = void function(GLenum, GLenum, GLfloat*);
	alias fp_glPixelTransformParameteriEXT = void function(GLenum, GLenum, GLint);
	alias fp_glPixelTransformParameterfEXT = void function(GLenum, GLenum, GLfloat);
	alias fp_glPixelTransformParameterivEXT = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glPixelTransformParameterfvEXT = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glGetPixelTransformParameterivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glGetPixelTransformParameterfvEXT = void function(GLenum, GLenum, GLfloat*);
	alias fp_glPointParameterfEXT = void function(GLenum, GLfloat);
	alias fp_glPointParameterfvEXT = void function(GLenum, const(GLfloat)*);
	alias fp_glPolygonOffsetEXT = void function(GLfloat, GLfloat);
	alias fp_glPolygonOffsetClampEXT = void function(GLfloat, GLfloat, GLfloat);
	alias fp_glProvokingVertexEXT = void function(GLenum);
	alias fp_glRasterSamplesEXT = void function(GLuint, GLboolean);
	alias fp_glSecondaryColor3bEXT = void function(GLbyte, GLbyte, GLbyte);
	alias fp_glSecondaryColor3bvEXT = void function(const(GLbyte)*);
	alias fp_glSecondaryColor3dEXT = void function(GLdouble, GLdouble, GLdouble);
	alias fp_glSecondaryColor3dvEXT = void function(const(GLdouble)*);
	alias fp_glSecondaryColor3fEXT = void function(GLfloat, GLfloat, GLfloat);
	alias fp_glSecondaryColor3fvEXT = void function(const(GLfloat)*);
	alias fp_glSecondaryColor3iEXT = void function(GLint, GLint, GLint);
	alias fp_glSecondaryColor3ivEXT = void function(const(GLint)*);
	alias fp_glSecondaryColor3sEXT = void function(GLshort, GLshort, GLshort);
	alias fp_glSecondaryColor3svEXT = void function(const(GLshort)*);
	alias fp_glSecondaryColor3ubEXT = void function(GLubyte, GLubyte, GLubyte);
	alias fp_glSecondaryColor3ubvEXT = void function(const(GLubyte)*);
	alias fp_glSecondaryColor3uiEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glSecondaryColor3uivEXT = void function(const(GLuint)*);
	alias fp_glSecondaryColor3usEXT = void function(GLushort, GLushort, GLushort);
	alias fp_glSecondaryColor3usvEXT = void function(const(GLushort)*);
	alias fp_glSecondaryColorPointerEXT = void function(GLint, GLenum, GLsizei, const(void)*);
	alias fp_glUseShaderProgramEXT = void function(GLenum, GLuint);
	alias fp_glActiveProgramEXT = void function(GLuint);
	alias fp_glCreateShaderProgramEXT = GLuint function(GLenum, const(GLchar)*);
	alias fp_glActiveShaderProgramEXT = void function(GLuint, GLuint);
	alias fp_glBindProgramPipelineEXT = void function(GLuint);
	alias fp_glCreateShaderProgramvEXT = GLuint function(GLenum, GLsizei, const(GLchar*)*);
	alias fp_glDeleteProgramPipelinesEXT = void function(GLsizei, const(GLuint)*);
	alias fp_glGenProgramPipelinesEXT = void function(GLsizei, GLuint*);
	alias fp_glGetProgramPipelineInfoLogEXT = void function(GLuint, GLsizei, GLsizei*,
		GLchar*);
	alias fp_glGetProgramPipelineivEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glIsProgramPipelineEXT = GLboolean function(GLuint);
	alias fp_glUseProgramStagesEXT = void function(GLuint, GLbitfield, GLuint);
	alias fp_glValidateProgramPipelineEXT = void function(GLuint);
	alias fp_glBindImageTextureEXT = void function(GLuint, GLuint, GLint,
		GLboolean, GLint, GLenum, GLint);
	alias fp_glMemoryBarrierEXT = void function(GLbitfield);
	alias fp_glStencilClearTagEXT = void function(GLsizei, GLuint);
	alias fp_glActiveStencilFaceEXT = void function(GLenum);
	alias fp_glTexSubImage1DEXT = void function(GLenum, GLint, GLint, GLsizei,
		GLenum, GLenum, const(void)*);
	alias fp_glTexSubImage2DEXT = void function(GLenum, GLint, GLint, GLint,
		GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glTexImage3DEXT = void function(GLenum, GLint, GLenum, GLsizei,
		GLsizei, GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glTexSubImage3DEXT = void function(GLenum, GLint, GLint, GLint,
		GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glFramebufferTextureLayerEXT = void function(GLenum, GLenum, GLuint, GLint,
		GLint);
	alias fp_glTexBufferEXT = void function(GLenum, GLenum, GLuint);
	alias fp_glTexParameterIivEXT = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glTexParameterIuivEXT = void function(GLenum, GLenum, const(GLuint)*);
	alias fp_glGetTexParameterIivEXT = void function(GLenum, GLenum, GLint*);
	alias fp_glGetTexParameterIuivEXT = void function(GLenum, GLenum, GLuint*);
	alias fp_glClearColorIiEXT = void function(GLint, GLint, GLint, GLint);
	alias fp_glClearColorIuiEXT = void function(GLuint, GLuint, GLuint, GLuint);
	alias fp_glAreTexturesResidentEXT = GLboolean function(GLsizei, const(GLuint)*,
		GLboolean*);
	alias fp_glBindTextureEXT = void function(GLenum, GLuint);
	alias fp_glDeleteTexturesEXT = void function(GLsizei, const(GLuint)*);
	alias fp_glGenTexturesEXT = void function(GLsizei, GLuint*);
	alias fp_glIsTextureEXT = GLboolean function(GLuint);
	alias fp_glPrioritizeTexturesEXT = void function(GLsizei, const(GLuint)*, const(GLclampf)*);
	alias fp_glTextureNormalEXT = void function(GLenum);
	alias fp_glGetQueryObjecti64vEXT = void function(GLuint, GLenum, GLint64*);
	alias fp_glGetQueryObjectui64vEXT = void function(GLuint, GLenum, GLuint64*);
	alias fp_glBeginTransformFeedbackEXT = void function(GLenum);
	alias fp_glEndTransformFeedbackEXT = void function();
	alias fp_glBindBufferRangeEXT = void function(GLenum, GLuint, GLuint, GLintptr,
		GLsizeiptr);
	alias fp_glBindBufferOffsetEXT = void function(GLenum, GLuint, GLuint, GLintptr);
	alias fp_glBindBufferBaseEXT = void function(GLenum, GLuint, GLuint);
	alias fp_glTransformFeedbackVaryingsEXT = void function(GLuint, GLsizei,
		const(GLchar*)*, GLenum);
	alias fp_glGetTransformFeedbackVaryingEXT = void function(GLuint, GLuint,
		GLsizei, GLsizei*, GLsizei*, GLenum*, GLchar*);
	alias fp_glArrayElementEXT = void function(GLint);
	alias fp_glColorPointerEXT = void function(GLint, GLenum, GLsizei, GLsizei, const(void)*);
	alias fp_glDrawArraysEXT = void function(GLenum, GLint, GLsizei);
	alias fp_glEdgeFlagPointerEXT = void function(GLsizei, GLsizei, const(GLboolean)*);
	alias fp_glGetPointervEXT = void function(GLenum, void**);
	alias fp_glIndexPointerEXT = void function(GLenum, GLsizei, GLsizei, const(void)*);
	alias fp_glNormalPointerEXT = void function(GLenum, GLsizei, GLsizei, const(void)*);
	alias fp_glTexCoordPointerEXT = void function(GLint, GLenum, GLsizei, GLsizei,
		const(void)*);
	alias fp_glVertexPointerEXT = void function(GLint, GLenum, GLsizei, GLsizei, const(void)*);
	alias fp_glVertexAttribL1dEXT = void function(GLuint, GLdouble);
	alias fp_glVertexAttribL2dEXT = void function(GLuint, GLdouble, GLdouble);
	alias fp_glVertexAttribL3dEXT = void function(GLuint, GLdouble, GLdouble, GLdouble);
	alias fp_glVertexAttribL4dEXT = void function(GLuint, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glVertexAttribL1dvEXT = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribL2dvEXT = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribL3dvEXT = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribL4dvEXT = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttribLPointerEXT = void function(GLuint, GLint, GLenum,
		GLsizei, const(void)*);
	alias fp_glGetVertexAttribLdvEXT = void function(GLuint, GLenum, GLdouble*);
	alias fp_glBeginVertexShaderEXT = void function();
	alias fp_glEndVertexShaderEXT = void function();
	alias fp_glBindVertexShaderEXT = void function(GLuint);
	alias fp_glGenVertexShadersEXT = GLuint function(GLuint);
	alias fp_glDeleteVertexShaderEXT = void function(GLuint);
	alias fp_glShaderOp1EXT = void function(GLenum, GLuint, GLuint);
	alias fp_glShaderOp2EXT = void function(GLenum, GLuint, GLuint, GLuint);
	alias fp_glShaderOp3EXT = void function(GLenum, GLuint, GLuint, GLuint, GLuint);
	alias fp_glSwizzleEXT = void function(GLuint, GLuint, GLenum, GLenum, GLenum, GLenum);
	alias fp_glWriteMaskEXT = void function(GLuint, GLuint, GLenum, GLenum, GLenum,
		GLenum);
	alias fp_glInsertComponentEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glExtractComponentEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glGenSymbolsEXT = GLuint function(GLenum, GLenum, GLenum, GLuint);
	alias fp_glSetInvariantEXT = void function(GLuint, GLenum, const(void)*);
	alias fp_glSetLocalConstantEXT = void function(GLuint, GLenum, const(void)*);
	alias fp_glVariantbvEXT = void function(GLuint, const(GLbyte)*);
	alias fp_glVariantsvEXT = void function(GLuint, const(GLshort)*);
	alias fp_glVariantivEXT = void function(GLuint, const(GLint)*);
	alias fp_glVariantfvEXT = void function(GLuint, const(GLfloat)*);
	alias fp_glVariantdvEXT = void function(GLuint, const(GLdouble)*);
	alias fp_glVariantubvEXT = void function(GLuint, const(GLubyte)*);
	alias fp_glVariantusvEXT = void function(GLuint, const(GLushort)*);
	alias fp_glVariantuivEXT = void function(GLuint, const(GLuint)*);
	alias fp_glVariantPointerEXT = void function(GLuint, GLenum, GLuint, const(void)*);
	alias fp_glEnableVariantClientStateEXT = void function(GLuint);
	alias fp_glDisableVariantClientStateEXT = void function(GLuint);
	alias fp_glBindLightParameterEXT = GLuint function(GLenum, GLenum);
	alias fp_glBindMaterialParameterEXT = GLuint function(GLenum, GLenum);
	alias fp_glBindTexGenParameterEXT = GLuint function(GLenum, GLenum, GLenum);
	alias fp_glBindTextureUnitParameterEXT = GLuint function(GLenum, GLenum);
	alias fp_glBindParameterEXT = GLuint function(GLenum);
	alias fp_glIsVariantEnabledEXT = GLboolean function(GLuint, GLenum);
	alias fp_glGetVariantBooleanvEXT = void function(GLuint, GLenum, GLboolean*);
	alias fp_glGetVariantIntegervEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVariantFloatvEXT = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetVariantPointervEXT = void function(GLuint, GLenum, void**);
	alias fp_glGetInvariantBooleanvEXT = void function(GLuint, GLenum, GLboolean*);
	alias fp_glGetInvariantIntegervEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glGetInvariantFloatvEXT = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetLocalConstantBooleanvEXT = void function(GLuint, GLenum, GLboolean*);
	alias fp_glGetLocalConstantIntegervEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glGetLocalConstantFloatvEXT = void function(GLuint, GLenum, GLfloat*);
	alias fp_glVertexWeightfEXT = void function(GLfloat);
	alias fp_glVertexWeightfvEXT = void function(const(GLfloat)*);
	alias fp_glVertexWeightPointerEXT = void function(GLint, GLenum, GLsizei, const(void)*);
	alias fp_glImportSyncEXT = GLsync function(GLenum, GLintptr, GLbitfield);
	alias fp_glFrameTerminatorGREMEDY = void function();
	alias fp_glStringMarkerGREMEDY = void function(GLsizei, const(void)*);
	alias fp_glImageTransformParameteriHP = void function(GLenum, GLenum, GLint);
	alias fp_glImageTransformParameterfHP = void function(GLenum, GLenum, GLfloat);
	alias fp_glImageTransformParameterivHP = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glImageTransformParameterfvHP = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glGetImageTransformParameterivHP = void function(GLenum, GLenum, GLint*);
	alias fp_glGetImageTransformParameterfvHP = void function(GLenum, GLenum, GLfloat*);
	alias fp_glMultiModeDrawArraysIBM = void function(const(GLenum)*,
		const(GLint)*, const(GLsizei)*, GLsizei, GLint);
	alias fp_glMultiModeDrawElementsIBM = void function(const(GLenum)*,
		const(GLsizei)*, GLenum, const(void*)*, GLsizei, GLint);
	alias fp_glFlushStaticDataIBM = void function(GLenum);
	alias fp_glColorPointerListIBM = void function(GLint, GLenum, GLint, const(void*)*,
		GLint);
	alias fp_glSecondaryColorPointerListIBM = void function(GLint, GLenum,
		GLint, const(void*)*, GLint);
	alias fp_glEdgeFlagPointerListIBM = void function(GLint, const(GLboolean*)*, GLint);
	alias fp_glFogCoordPointerListIBM = void function(GLenum, GLint, const(void*)*,
		GLint);
	alias fp_glIndexPointerListIBM = void function(GLenum, GLint, const(void*)*, GLint);
	alias fp_glNormalPointerListIBM = void function(GLenum, GLint, const(void*)*, GLint);
	alias fp_glTexCoordPointerListIBM = void function(GLint, GLenum, GLint,
		const(void*)*, GLint);
	alias fp_glVertexPointerListIBM = void function(GLint, GLenum, GLint, const(void*)*,
		GLint);
	alias fp_glBlendFuncSeparateINGR = void function(GLenum, GLenum, GLenum, GLenum);
	alias fp_glApplyFramebufferAttachmentCMAAINTEL = void function();
	alias fp_glSyncTextureINTEL = void function(GLuint);
	alias fp_glUnmapTexture2DINTEL = void function(GLuint, GLint);
	alias fp_glMapTexture2DINTEL = void* function(GLuint, GLint, GLbitfield, GLint*,
		GLenum*);
	alias fp_glVertexPointervINTEL = void function(GLint, GLenum, const(void*)*);
	alias fp_glNormalPointervINTEL = void function(GLenum, const(void*)*);
	alias fp_glColorPointervINTEL = void function(GLint, GLenum, const(void*)*);
	alias fp_glTexCoordPointervINTEL = void function(GLint, GLenum, const(void*)*);
	alias fp_glBeginPerfQueryINTEL = void function(GLuint);
	alias fp_glCreatePerfQueryINTEL = void function(GLuint, GLuint*);
	alias fp_glDeletePerfQueryINTEL = void function(GLuint);
	alias fp_glEndPerfQueryINTEL = void function(GLuint);
	alias fp_glGetFirstPerfQueryIdINTEL = void function(GLuint*);
	alias fp_glGetNextPerfQueryIdINTEL = void function(GLuint, GLuint*);
	alias fp_glGetPerfCounterInfoINTEL = void function(GLuint, GLuint, GLuint,
		GLchar*, GLuint, GLchar*, GLuint*, GLuint*, GLuint*, GLuint*, GLuint64*);
	alias fp_glGetPerfQueryDataINTEL = void function(GLuint, GLuint, GLsizei, GLvoid*,
		GLuint*);
	alias fp_glGetPerfQueryIdByNameINTEL = void function(GLchar*, GLuint*);
	alias fp_glGetPerfQueryInfoINTEL = void function(GLuint, GLuint, GLchar*,
		GLuint*, GLuint*, GLuint*, GLuint*);
	alias fp_glBlendBarrierKHR = void function();
	alias fp_glDebugMessageControl = void function(GLenum, GLenum, GLenum,
		GLsizei, const(GLuint)*, GLboolean);
	alias fp_glDebugMessageInsert = void function(GLenum, GLenum, GLuint,
		GLenum, GLsizei, const(GLchar)*);
	alias fp_glDebugMessageCallback = void function(GLDEBUGPROC, const(void)*);
	alias fp_glGetDebugMessageLog = GLuint function(GLuint, GLsizei, GLenum*,
		GLenum*, GLuint*, GLenum*, GLsizei*, GLchar*);
	alias fp_glPushDebugGroup = void function(GLenum, GLuint, GLsizei, const(GLchar)*);
	alias fp_glPopDebugGroup = void function();
	alias fp_glObjectLabel = void function(GLenum, GLuint, GLsizei, const(GLchar)*);
	alias fp_glGetObjectLabel = void function(GLenum, GLuint, GLsizei, GLsizei*, GLchar*);
	alias fp_glObjectPtrLabel = void function(const(void)*, GLsizei, const(GLchar)*);
	alias fp_glGetObjectPtrLabel = void function(const(void)*, GLsizei, GLsizei*, GLchar*);
	alias fp_glDebugMessageControlKHR = void function(GLenum, GLenum, GLenum,
		GLsizei, const(GLuint)*, GLboolean);
	alias fp_glDebugMessageInsertKHR = void function(GLenum, GLenum, GLuint,
		GLenum, GLsizei, const(GLchar)*);
	alias fp_glDebugMessageCallbackKHR = void function(GLDEBUGPROCKHR, const(void)*);
	alias fp_glGetDebugMessageLogKHR = GLuint function(GLuint, GLsizei,
		GLenum*, GLenum*, GLuint*, GLenum*, GLsizei*, GLchar*);
	alias fp_glPushDebugGroupKHR = void function(GLenum, GLuint, GLsizei, const(GLchar)*);
	alias fp_glPopDebugGroupKHR = void function();
	alias fp_glObjectLabelKHR = void function(GLenum, GLuint, GLsizei, const(GLchar)*);
	alias fp_glGetObjectLabelKHR = void function(GLenum, GLuint, GLsizei, GLsizei*,
		GLchar*);
	alias fp_glObjectPtrLabelKHR = void function(const(void)*, GLsizei, const(GLchar)*);
	alias fp_glGetObjectPtrLabelKHR = void function(const(void)*, GLsizei, GLsizei*,
		GLchar*);
	alias fp_glGetPointervKHR = void function(GLenum, void**);
	alias fp_glGetGraphicsResetStatus = GLenum function();
	alias fp_glReadnPixels = void function(GLint, GLint, GLsizei, GLsizei,
		GLenum, GLenum, GLsizei, void*);
	alias fp_glGetnUniformfv = void function(GLuint, GLint, GLsizei, GLfloat*);
	alias fp_glGetnUniformiv = void function(GLuint, GLint, GLsizei, GLint*);
	alias fp_glGetnUniformuiv = void function(GLuint, GLint, GLsizei, GLuint*);
	alias fp_glGetGraphicsResetStatusKHR = GLenum function();
	alias fp_glReadnPixelsKHR = void function(GLint, GLint, GLsizei, GLsizei,
		GLenum, GLenum, GLsizei, void*);
	alias fp_glGetnUniformfvKHR = void function(GLuint, GLint, GLsizei, GLfloat*);
	alias fp_glGetnUniformivKHR = void function(GLuint, GLint, GLsizei, GLint*);
	alias fp_glGetnUniformuivKHR = void function(GLuint, GLint, GLsizei, GLuint*);
	alias fp_glResizeBuffersMESA = void function();
	alias fp_glWindowPos2dMESA = void function(GLdouble, GLdouble);
	alias fp_glWindowPos2dvMESA = void function(const(GLdouble)*);
	alias fp_glWindowPos2fMESA = void function(GLfloat, GLfloat);
	alias fp_glWindowPos2fvMESA = void function(const(GLfloat)*);
	alias fp_glWindowPos2iMESA = void function(GLint, GLint);
	alias fp_glWindowPos2ivMESA = void function(const(GLint)*);
	alias fp_glWindowPos2sMESA = void function(GLshort, GLshort);
	alias fp_glWindowPos2svMESA = void function(const(GLshort)*);
	alias fp_glWindowPos3dMESA = void function(GLdouble, GLdouble, GLdouble);
	alias fp_glWindowPos3dvMESA = void function(const(GLdouble)*);
	alias fp_glWindowPos3fMESA = void function(GLfloat, GLfloat, GLfloat);
	alias fp_glWindowPos3fvMESA = void function(const(GLfloat)*);
	alias fp_glWindowPos3iMESA = void function(GLint, GLint, GLint);
	alias fp_glWindowPos3ivMESA = void function(const(GLint)*);
	alias fp_glWindowPos3sMESA = void function(GLshort, GLshort, GLshort);
	alias fp_glWindowPos3svMESA = void function(const(GLshort)*);
	alias fp_glWindowPos4dMESA = void function(GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glWindowPos4dvMESA = void function(const(GLdouble)*);
	alias fp_glWindowPos4fMESA = void function(GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glWindowPos4fvMESA = void function(const(GLfloat)*);
	alias fp_glWindowPos4iMESA = void function(GLint, GLint, GLint, GLint);
	alias fp_glWindowPos4ivMESA = void function(const(GLint)*);
	alias fp_glWindowPos4sMESA = void function(GLshort, GLshort, GLshort, GLshort);
	alias fp_glWindowPos4svMESA = void function(const(GLshort)*);
	alias fp_glBeginConditionalRenderNVX = void function(GLuint);
	alias fp_glEndConditionalRenderNVX = void function();
	alias fp_glMultiDrawArraysIndirectBindlessNV = void function(GLenum,
		const(void)*, GLsizei, GLsizei, GLint);
	alias fp_glMultiDrawElementsIndirectBindlessNV = void function(GLenum,
		GLenum, const(void)*, GLsizei, GLsizei, GLint);
	alias fp_glMultiDrawArraysIndirectBindlessCountNV = void function(GLenum,
		const(void)*, GLsizei, GLsizei, GLsizei, GLint);
	alias fp_glMultiDrawElementsIndirectBindlessCountNV = void function(GLenum,
		GLenum, const(void)*, GLsizei, GLsizei, GLsizei, GLint);
	alias fp_glGetTextureHandleNV = GLuint64 function(GLuint);
	alias fp_glGetTextureSamplerHandleNV = GLuint64 function(GLuint, GLuint);
	alias fp_glMakeTextureHandleResidentNV = void function(GLuint64);
	alias fp_glMakeTextureHandleNonResidentNV = void function(GLuint64);
	alias fp_glGetImageHandleNV = GLuint64 function(GLuint, GLint, GLboolean, GLint,
		GLenum);
	alias fp_glMakeImageHandleResidentNV = void function(GLuint64, GLenum);
	alias fp_glMakeImageHandleNonResidentNV = void function(GLuint64);
	alias fp_glUniformHandleui64NV = void function(GLint, GLuint64);
	alias fp_glUniformHandleui64vNV = void function(GLint, GLsizei, const(GLuint64)*);
	alias fp_glProgramUniformHandleui64NV = void function(GLuint, GLint, GLuint64);
	alias fp_glProgramUniformHandleui64vNV = void function(GLuint, GLint,
		GLsizei, const(GLuint64)*);
	alias fp_glIsTextureHandleResidentNV = GLboolean function(GLuint64);
	alias fp_glIsImageHandleResidentNV = GLboolean function(GLuint64);
	alias fp_glBlendParameteriNV = void function(GLenum, GLint);
	alias fp_glBlendBarrierNV = void function();
	alias fp_glCreateStatesNV = void function(GLsizei, GLuint*);
	alias fp_glDeleteStatesNV = void function(GLsizei, const(GLuint)*);
	alias fp_glIsStateNV = GLboolean function(GLuint);
	alias fp_glStateCaptureNV = void function(GLuint, GLenum);
	alias fp_glGetCommandHeaderNV = GLuint function(GLenum, GLuint);
	alias fp_glGetStageIndexNV = GLushort function(GLenum);
	alias fp_glDrawCommandsNV = void function(GLenum, GLuint,
		const(GLintptr)*, const(GLsizei)*, GLuint);
	alias fp_glDrawCommandsAddressNV = void function(GLenum, const(GLuint64)*,
		const(GLsizei)*, GLuint);
	alias fp_glDrawCommandsStatesNV = void function(GLuint, const(GLintptr)*,
		const(GLsizei)*, const(GLuint)*, const(GLuint)*, GLuint);
	alias fp_glDrawCommandsStatesAddressNV = void function(const(GLuint64)*,
		const(GLsizei)*, const(GLuint)*, const(GLuint)*, GLuint);
	alias fp_glCreateCommandListsNV = void function(GLsizei, GLuint*);
	alias fp_glDeleteCommandListsNV = void function(GLsizei, const(GLuint)*);
	alias fp_glIsCommandListNV = GLboolean function(GLuint);
	alias fp_glListDrawCommandsStatesClientNV = void function(GLuint, GLuint,
		const(void*)*, const(GLsizei)*, const(GLuint)*, const(GLuint)*, GLuint);
	alias fp_glCommandListSegmentsNV = void function(GLuint, GLuint);
	alias fp_glCompileCommandListNV = void function(GLuint);
	alias fp_glCallCommandListNV = void function(GLuint);
	alias fp_glBeginConditionalRenderNV = void function(GLuint, GLenum);
	alias fp_glEndConditionalRenderNV = void function();
	alias fp_glSubpixelPrecisionBiasNV = void function(GLuint, GLuint);
	alias fp_glConservativeRasterParameterfNV = void function(GLenum, GLfloat);
	alias fp_glCopyImageSubDataNV = void function(GLuint, GLenum, GLint, GLint,
		GLint, GLint, GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei,
		GLsizei);
	alias fp_glDepthRangedNV = void function(GLdouble, GLdouble);
	alias fp_glClearDepthdNV = void function(GLdouble);
	alias fp_glDepthBoundsdNV = void function(GLdouble, GLdouble);
	alias fp_glDrawTextureNV = void function(GLuint, GLuint, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glMapControlPointsNV = void function(GLenum, GLuint, GLenum,
		GLsizei, GLsizei, GLint, GLint, GLboolean, const(void)*);
	alias fp_glMapParameterivNV = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glMapParameterfvNV = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glGetMapControlPointsNV = void function(GLenum, GLuint, GLenum,
		GLsizei, GLsizei, GLboolean, void*);
	alias fp_glGetMapParameterivNV = void function(GLenum, GLenum, GLint*);
	alias fp_glGetMapParameterfvNV = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetMapAttribParameterivNV = void function(GLenum, GLuint, GLenum, GLint*);
	alias fp_glGetMapAttribParameterfvNV = void function(GLenum, GLuint, GLenum, GLfloat*);
	alias fp_glEvalMapsNV = void function(GLenum, GLenum);
	alias fp_glGetMultisamplefvNV = void function(GLenum, GLuint, GLfloat*);
	alias fp_glSampleMaskIndexedNV = void function(GLuint, GLbitfield);
	alias fp_glTexRenderbufferNV = void function(GLenum, GLuint);
	alias fp_glDeleteFencesNV = void function(GLsizei, const(GLuint)*);
	alias fp_glGenFencesNV = void function(GLsizei, GLuint*);
	alias fp_glIsFenceNV = GLboolean function(GLuint);
	alias fp_glTestFenceNV = GLboolean function(GLuint);
	alias fp_glGetFenceivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glFinishFenceNV = void function(GLuint);
	alias fp_glSetFenceNV = void function(GLuint, GLenum);
	alias fp_glFragmentCoverageColorNV = void function(GLuint);
	alias fp_glProgramNamedParameter4fNV = void function(GLuint, GLsizei,
		const(GLubyte)*, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glProgramNamedParameter4fvNV = void function(GLuint, GLsizei,
		const(GLubyte)*, const(GLfloat)*);
	alias fp_glProgramNamedParameter4dNV = void function(GLuint, GLsizei,
		const(GLubyte)*, GLdouble, GLdouble, GLdouble, GLdouble);
	alias fp_glProgramNamedParameter4dvNV = void function(GLuint, GLsizei,
		const(GLubyte)*, const(GLdouble)*);
	alias fp_glGetProgramNamedParameterfvNV = void function(GLuint, GLsizei,
		const(GLubyte)*, GLfloat*);
	alias fp_glGetProgramNamedParameterdvNV = void function(GLuint, GLsizei,
		const(GLubyte)*, GLdouble*);
	alias fp_glCoverageModulationTableNV = void function(GLsizei, const(GLfloat)*);
	alias fp_glGetCoverageModulationTableNV = void function(GLsizei, GLfloat*);
	alias fp_glCoverageModulationNV = void function(GLenum);
	alias fp_glRenderbufferStorageMultisampleCoverageNV = void function(GLenum,
		GLsizei, GLsizei, GLenum, GLsizei, GLsizei);
	alias fp_glProgramVertexLimitNV = void function(GLenum, GLint);
	alias fp_glFramebufferTextureEXT = void function(GLenum, GLenum, GLuint, GLint);
	alias fp_glFramebufferTextureFaceEXT = void function(GLenum, GLenum, GLuint, GLint,
		GLenum);
	alias fp_glProgramLocalParameterI4iNV = void function(GLenum, GLuint,
		GLint, GLint, GLint, GLint);
	alias fp_glProgramLocalParameterI4ivNV = void function(GLenum, GLuint, const(GLint)*);
	alias fp_glProgramLocalParametersI4ivNV = void function(GLenum, GLuint,
		GLsizei, const(GLint)*);
	alias fp_glProgramLocalParameterI4uiNV = void function(GLenum, GLuint,
		GLuint, GLuint, GLuint, GLuint);
	alias fp_glProgramLocalParameterI4uivNV = void function(GLenum, GLuint, const(GLuint)*);
	alias fp_glProgramLocalParametersI4uivNV = void function(GLenum, GLuint,
		GLsizei, const(GLuint)*);
	alias fp_glProgramEnvParameterI4iNV = void function(GLenum, GLuint,
		GLint, GLint, GLint, GLint);
	alias fp_glProgramEnvParameterI4ivNV = void function(GLenum, GLuint, const(GLint)*);
	alias fp_glProgramEnvParametersI4ivNV = void function(GLenum, GLuint, GLsizei,
		const(GLint)*);
	alias fp_glProgramEnvParameterI4uiNV = void function(GLenum, GLuint,
		GLuint, GLuint, GLuint, GLuint);
	alias fp_glProgramEnvParameterI4uivNV = void function(GLenum, GLuint, const(GLuint)*);
	alias fp_glProgramEnvParametersI4uivNV = void function(GLenum, GLuint,
		GLsizei, const(GLuint)*);
	alias fp_glGetProgramLocalParameterIivNV = void function(GLenum, GLuint, GLint*);
	alias fp_glGetProgramLocalParameterIuivNV = void function(GLenum, GLuint, GLuint*);
	alias fp_glGetProgramEnvParameterIivNV = void function(GLenum, GLuint, GLint*);
	alias fp_glGetProgramEnvParameterIuivNV = void function(GLenum, GLuint, GLuint*);
	alias fp_glProgramSubroutineParametersuivNV = void function(GLenum, GLsizei, const(GLuint)*);
	alias fp_glGetProgramSubroutineParameteruivNV = void function(GLenum, GLuint, GLuint*);
	alias fp_glVertex2hNV = void function(GLhalfNV, GLhalfNV);
	alias fp_glVertex2hvNV = void function(const(GLhalfNV)*);
	alias fp_glVertex3hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glVertex3hvNV = void function(const(GLhalfNV)*);
	alias fp_glVertex4hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glVertex4hvNV = void function(const(GLhalfNV)*);
	alias fp_glNormal3hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glNormal3hvNV = void function(const(GLhalfNV)*);
	alias fp_glColor3hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glColor3hvNV = void function(const(GLhalfNV)*);
	alias fp_glColor4hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glColor4hvNV = void function(const(GLhalfNV)*);
	alias fp_glTexCoord1hNV = void function(GLhalfNV);
	alias fp_glTexCoord1hvNV = void function(const(GLhalfNV)*);
	alias fp_glTexCoord2hNV = void function(GLhalfNV, GLhalfNV);
	alias fp_glTexCoord2hvNV = void function(const(GLhalfNV)*);
	alias fp_glTexCoord3hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glTexCoord3hvNV = void function(const(GLhalfNV)*);
	alias fp_glTexCoord4hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glTexCoord4hvNV = void function(const(GLhalfNV)*);
	alias fp_glMultiTexCoord1hNV = void function(GLenum, GLhalfNV);
	alias fp_glMultiTexCoord1hvNV = void function(GLenum, const(GLhalfNV)*);
	alias fp_glMultiTexCoord2hNV = void function(GLenum, GLhalfNV, GLhalfNV);
	alias fp_glMultiTexCoord2hvNV = void function(GLenum, const(GLhalfNV)*);
	alias fp_glMultiTexCoord3hNV = void function(GLenum, GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glMultiTexCoord3hvNV = void function(GLenum, const(GLhalfNV)*);
	alias fp_glMultiTexCoord4hNV = void function(GLenum, GLhalfNV, GLhalfNV, GLhalfNV,
		GLhalfNV);
	alias fp_glMultiTexCoord4hvNV = void function(GLenum, const(GLhalfNV)*);
	alias fp_glFogCoordhNV = void function(GLhalfNV);
	alias fp_glFogCoordhvNV = void function(const(GLhalfNV)*);
	alias fp_glSecondaryColor3hNV = void function(GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glSecondaryColor3hvNV = void function(const(GLhalfNV)*);
	alias fp_glVertexWeighthNV = void function(GLhalfNV);
	alias fp_glVertexWeighthvNV = void function(const(GLhalfNV)*);
	alias fp_glVertexAttrib1hNV = void function(GLuint, GLhalfNV);
	alias fp_glVertexAttrib1hvNV = void function(GLuint, const(GLhalfNV)*);
	alias fp_glVertexAttrib2hNV = void function(GLuint, GLhalfNV, GLhalfNV);
	alias fp_glVertexAttrib2hvNV = void function(GLuint, const(GLhalfNV)*);
	alias fp_glVertexAttrib3hNV = void function(GLuint, GLhalfNV, GLhalfNV, GLhalfNV);
	alias fp_glVertexAttrib3hvNV = void function(GLuint, const(GLhalfNV)*);
	alias fp_glVertexAttrib4hNV = void function(GLuint, GLhalfNV, GLhalfNV, GLhalfNV,
		GLhalfNV);
	alias fp_glVertexAttrib4hvNV = void function(GLuint, const(GLhalfNV)*);
	alias fp_glVertexAttribs1hvNV = void function(GLuint, GLsizei, const(GLhalfNV)*);
	alias fp_glVertexAttribs2hvNV = void function(GLuint, GLsizei, const(GLhalfNV)*);
	alias fp_glVertexAttribs3hvNV = void function(GLuint, GLsizei, const(GLhalfNV)*);
	alias fp_glVertexAttribs4hvNV = void function(GLuint, GLsizei, const(GLhalfNV)*);
	alias fp_glGetInternalformatSampleivNV = void function(GLenum, GLenum,
		GLsizei, GLenum, GLsizei, GLint*);
	alias fp_glGenOcclusionQueriesNV = void function(GLsizei, GLuint*);
	alias fp_glDeleteOcclusionQueriesNV = void function(GLsizei, const(GLuint)*);
	alias fp_glIsOcclusionQueryNV = GLboolean function(GLuint);
	alias fp_glBeginOcclusionQueryNV = void function(GLuint);
	alias fp_glEndOcclusionQueryNV = void function();
	alias fp_glGetOcclusionQueryivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glGetOcclusionQueryuivNV = void function(GLuint, GLenum, GLuint*);
	alias fp_glProgramBufferParametersfvNV = void function(GLenum, GLuint,
		GLuint, GLsizei, const(GLfloat)*);
	alias fp_glProgramBufferParametersIivNV = void function(GLenum, GLuint,
		GLuint, GLsizei, const(GLint)*);
	alias fp_glProgramBufferParametersIuivNV = void function(GLenum, GLuint,
		GLuint, GLsizei, const(GLuint)*);
	alias fp_glGenPathsNV = GLuint function(GLsizei);
	alias fp_glDeletePathsNV = void function(GLuint, GLsizei);
	alias fp_glIsPathNV = GLboolean function(GLuint);
	alias fp_glPathCommandsNV = void function(GLuint, GLsizei,
		const(GLubyte)*, GLsizei, GLenum, const(void)*);
	alias fp_glPathCoordsNV = void function(GLuint, GLsizei, GLenum, const(void)*);
	alias fp_glPathSubCommandsNV = void function(GLuint, GLsizei, GLsizei,
		GLsizei, const(GLubyte)*, GLsizei, GLenum, const(void)*);
	alias fp_glPathSubCoordsNV = void function(GLuint, GLsizei, GLsizei, GLenum, const(void)*);
	alias fp_glPathStringNV = void function(GLuint, GLenum, GLsizei, const(void)*);
	alias fp_glPathGlyphsNV = void function(GLuint, GLenum, const(void)*,
		GLbitfield, GLsizei, GLenum, const(void)*, GLenum, GLuint, GLfloat);
	alias fp_glPathGlyphRangeNV = void function(GLuint, GLenum, const(void)*,
		GLbitfield, GLuint, GLsizei, GLenum, GLuint, GLfloat);
	alias fp_glWeightPathsNV = void function(GLuint, GLsizei, const(GLuint)*, const(GLfloat)*);
	alias fp_glCopyPathNV = void function(GLuint, GLuint);
	alias fp_glInterpolatePathsNV = void function(GLuint, GLuint, GLuint, GLfloat);
	alias fp_glTransformPathNV = void function(GLuint, GLuint, GLenum, const(GLfloat)*);
	alias fp_glPathParameterivNV = void function(GLuint, GLenum, const(GLint)*);
	alias fp_glPathParameteriNV = void function(GLuint, GLenum, GLint);
	alias fp_glPathParameterfvNV = void function(GLuint, GLenum, const(GLfloat)*);
	alias fp_glPathParameterfNV = void function(GLuint, GLenum, GLfloat);
	alias fp_glPathDashArrayNV = void function(GLuint, GLsizei, const(GLfloat)*);
	alias fp_glPathStencilFuncNV = void function(GLenum, GLint, GLuint);
	alias fp_glPathStencilDepthOffsetNV = void function(GLfloat, GLfloat);
	alias fp_glStencilFillPathNV = void function(GLuint, GLenum, GLuint);
	alias fp_glStencilStrokePathNV = void function(GLuint, GLint, GLuint);
	alias fp_glStencilFillPathInstancedNV = void function(GLsizei, GLenum,
		const(void)*, GLuint, GLenum, GLuint, GLenum, const(GLfloat)*);
	alias fp_glStencilStrokePathInstancedNV = void function(GLsizei, GLenum,
		const(void)*, GLuint, GLint, GLuint, GLenum, const(GLfloat)*);
	alias fp_glPathCoverDepthFuncNV = void function(GLenum);
	alias fp_glCoverFillPathNV = void function(GLuint, GLenum);
	alias fp_glCoverStrokePathNV = void function(GLuint, GLenum);
	alias fp_glCoverFillPathInstancedNV = void function(GLsizei, GLenum,
		const(void)*, GLuint, GLenum, GLenum, const(GLfloat)*);
	alias fp_glCoverStrokePathInstancedNV = void function(GLsizei, GLenum,
		const(void)*, GLuint, GLenum, GLenum, const(GLfloat)*);
	alias fp_glGetPathParameterivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glGetPathParameterfvNV = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetPathCommandsNV = void function(GLuint, GLubyte*);
	alias fp_glGetPathCoordsNV = void function(GLuint, GLfloat*);
	alias fp_glGetPathDashArrayNV = void function(GLuint, GLfloat*);
	alias fp_glGetPathMetricsNV = void function(GLbitfield, GLsizei, GLenum,
		const(void)*, GLuint, GLsizei, GLfloat*);
	alias fp_glGetPathMetricRangeNV = void function(GLbitfield, GLuint,
		GLsizei, GLsizei, GLfloat*);
	alias fp_glGetPathSpacingNV = void function(GLenum, GLsizei, GLenum,
		const(void)*, GLuint, GLfloat, GLfloat, GLenum, GLfloat*);
	alias fp_glIsPointInFillPathNV = GLboolean function(GLuint, GLuint, GLfloat, GLfloat);
	alias fp_glIsPointInStrokePathNV = GLboolean function(GLuint, GLfloat, GLfloat);
	alias fp_glGetPathLengthNV = GLfloat function(GLuint, GLsizei, GLsizei);
	alias fp_glPointAlongPathNV = GLboolean function(GLuint, GLsizei, GLsizei,
		GLfloat, GLfloat*, GLfloat*, GLfloat*, GLfloat*);
	alias fp_glMatrixLoad3x2fNV = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixLoad3x3fNV = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixLoadTranspose3x3fNV = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixMult3x2fNV = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixMult3x3fNV = void function(GLenum, const(GLfloat)*);
	alias fp_glMatrixMultTranspose3x3fNV = void function(GLenum, const(GLfloat)*);
	alias fp_glStencilThenCoverFillPathNV = void function(GLuint, GLenum, GLuint, GLenum);
	alias fp_glStencilThenCoverStrokePathNV = void function(GLuint, GLint, GLuint,
		GLenum);
	alias fp_glStencilThenCoverFillPathInstancedNV = void function(GLsizei,
		GLenum, const(void)*, GLuint, GLenum, GLuint, GLenum, GLenum, const(GLfloat)*);
	alias fp_glStencilThenCoverStrokePathInstancedNV = void function(GLsizei,
		GLenum, const(void)*, GLuint, GLint, GLuint, GLenum, GLenum, const(GLfloat)*);
	alias fp_glPathGlyphIndexRangeNV = GLenum function(GLenum, const(void)*,
		GLbitfield, GLuint, GLfloat, GLuint*);
	alias fp_glPathGlyphIndexArrayNV = GLenum function(GLuint, GLenum,
		const(void)*, GLbitfield, GLuint, GLsizei, GLuint, GLfloat);
	alias fp_glPathMemoryGlyphIndexArrayNV = GLenum function(GLuint, GLenum,
		GLsizeiptr, const(void)*, GLsizei, GLuint, GLsizei, GLuint, GLfloat);
	alias fp_glProgramPathFragmentInputGenNV = void function(GLuint, GLint,
		GLenum, GLint, const(GLfloat)*);
	alias fp_glGetProgramResourcefvNV = void function(GLuint, GLenum, GLuint,
		GLsizei, const(GLenum)*, GLsizei, GLsizei*, GLfloat*);
	alias fp_glPathColorGenNV = void function(GLenum, GLenum, GLenum, const(GLfloat)*);
	alias fp_glPathTexGenNV = void function(GLenum, GLenum, GLint, const(GLfloat)*);
	alias fp_glPathFogGenNV = void function(GLenum);
	alias fp_glGetPathColorGenivNV = void function(GLenum, GLenum, GLint*);
	alias fp_glGetPathColorGenfvNV = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetPathTexGenivNV = void function(GLenum, GLenum, GLint*);
	alias fp_glGetPathTexGenfvNV = void function(GLenum, GLenum, GLfloat*);
	alias fp_glPixelDataRangeNV = void function(GLenum, GLsizei, const(void)*);
	alias fp_glFlushPixelDataRangeNV = void function(GLenum);
	alias fp_glPointParameteriNV = void function(GLenum, GLint);
	alias fp_glPointParameterivNV = void function(GLenum, const(GLint)*);
	alias fp_glPresentFrameKeyedNV = void function(GLuint, GLuint64EXT, GLuint,
		GLuint, GLenum, GLenum, GLuint, GLuint, GLenum, GLuint, GLuint);
	alias fp_glPresentFrameDualFillNV = void function(GLuint, GLuint64EXT,
		GLuint, GLuint, GLenum, GLenum, GLuint, GLenum, GLuint, GLenum, GLuint, GLenum,
		GLuint);
	alias fp_glGetVideoivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVideouivNV = void function(GLuint, GLenum, GLuint*);
	alias fp_glGetVideoi64vNV = void function(GLuint, GLenum, GLint64EXT*);
	alias fp_glGetVideoui64vNV = void function(GLuint, GLenum, GLuint64EXT*);
	alias fp_glPrimitiveRestartNV = void function();
	alias fp_glPrimitiveRestartIndexNV = void function(GLuint);
	alias fp_glCombinerParameterfvNV = void function(GLenum, const(GLfloat)*);
	alias fp_glCombinerParameterfNV = void function(GLenum, GLfloat);
	alias fp_glCombinerParameterivNV = void function(GLenum, const(GLint)*);
	alias fp_glCombinerParameteriNV = void function(GLenum, GLint);
	alias fp_glCombinerInputNV = void function(GLenum, GLenum, GLenum, GLenum, GLenum,
		GLenum);
	alias fp_glCombinerOutputNV = void function(GLenum, GLenum, GLenum, GLenum,
		GLenum, GLenum, GLenum, GLboolean, GLboolean, GLboolean);
	alias fp_glFinalCombinerInputNV = void function(GLenum, GLenum, GLenum, GLenum);
	alias fp_glGetCombinerInputParameterfvNV = void function(GLenum, GLenum,
		GLenum, GLenum, GLfloat*);
	alias fp_glGetCombinerInputParameterivNV = void function(GLenum, GLenum,
		GLenum, GLenum, GLint*);
	alias fp_glGetCombinerOutputParameterfvNV = void function(GLenum, GLenum, GLenum,
		GLfloat*);
	alias fp_glGetCombinerOutputParameterivNV = void function(GLenum, GLenum, GLenum,
		GLint*);
	alias fp_glGetFinalCombinerInputParameterfvNV = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetFinalCombinerInputParameterivNV = void function(GLenum, GLenum, GLint*);
	alias fp_glCombinerStageParameterfvNV = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glGetCombinerStageParameterfvNV = void function(GLenum, GLenum, GLfloat*);
	alias fp_glFramebufferSampleLocationsfvNV = void function(GLenum, GLuint,
		GLsizei, const(GLfloat)*);
	alias fp_glNamedFramebufferSampleLocationsfvNV = void function(GLuint,
		GLuint, GLsizei, const(GLfloat)*);
	alias fp_glResolveDepthValuesNV = void function();
	alias fp_glMakeBufferResidentNV = void function(GLenum, GLenum);
	alias fp_glMakeBufferNonResidentNV = void function(GLenum);
	alias fp_glIsBufferResidentNV = GLboolean function(GLenum);
	alias fp_glMakeNamedBufferResidentNV = void function(GLuint, GLenum);
	alias fp_glMakeNamedBufferNonResidentNV = void function(GLuint);
	alias fp_glIsNamedBufferResidentNV = GLboolean function(GLuint);
	alias fp_glGetBufferParameterui64vNV = void function(GLenum, GLenum, GLuint64EXT*);
	alias fp_glGetNamedBufferParameterui64vNV = void function(GLuint, GLenum, GLuint64EXT*);
	alias fp_glGetIntegerui64vNV = void function(GLenum, GLuint64EXT*);
	alias fp_glUniformui64NV = void function(GLint, GLuint64EXT);
	alias fp_glUniformui64vNV = void function(GLint, GLsizei, const(GLuint64EXT)*);
	alias fp_glProgramUniformui64NV = void function(GLuint, GLint, GLuint64EXT);
	alias fp_glProgramUniformui64vNV = void function(GLuint, GLint, GLsizei, const(GLuint64EXT)*);
	alias fp_glTextureBarrierNV = void function();
	alias fp_glTexImage2DMultisampleCoverageNV = void function(GLenum, GLsizei,
		GLsizei, GLint, GLsizei, GLsizei, GLboolean);
	alias fp_glTexImage3DMultisampleCoverageNV = void function(GLenum, GLsizei,
		GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureImage2DMultisampleNV = void function(GLuint, GLenum,
		GLsizei, GLint, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureImage3DMultisampleNV = void function(GLuint, GLenum,
		GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureImage2DMultisampleCoverageNV = void function(GLuint,
		GLenum, GLsizei, GLsizei, GLint, GLsizei, GLsizei, GLboolean);
	alias fp_glTextureImage3DMultisampleCoverageNV = void function(GLuint,
		GLenum, GLsizei, GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
	alias fp_glBeginTransformFeedbackNV = void function(GLenum);
	alias fp_glEndTransformFeedbackNV = void function();
	alias fp_glTransformFeedbackAttribsNV = void function(GLsizei, const(GLint)*, GLenum);
	alias fp_glBindBufferRangeNV = void function(GLenum, GLuint, GLuint, GLintptr,
		GLsizeiptr);
	alias fp_glBindBufferOffsetNV = void function(GLenum, GLuint, GLuint, GLintptr);
	alias fp_glBindBufferBaseNV = void function(GLenum, GLuint, GLuint);
	alias fp_glTransformFeedbackVaryingsNV = void function(GLuint, GLsizei,
		const(GLint)*, GLenum);
	alias fp_glActiveVaryingNV = void function(GLuint, const(GLchar)*);
	alias fp_glGetVaryingLocationNV = GLint function(GLuint, const(GLchar)*);
	alias fp_glGetActiveVaryingNV = void function(GLuint, GLuint, GLsizei,
		GLsizei*, GLsizei*, GLenum*, GLchar*);
	alias fp_glGetTransformFeedbackVaryingNV = void function(GLuint, GLuint, GLint*);
	alias fp_glTransformFeedbackStreamAttribsNV = void function(GLsizei,
		const(GLint)*, GLsizei, const(GLint)*, GLenum);
	alias fp_glBindTransformFeedbackNV = void function(GLenum, GLuint);
	alias fp_glDeleteTransformFeedbacksNV = void function(GLsizei, const(GLuint)*);
	alias fp_glGenTransformFeedbacksNV = void function(GLsizei, GLuint*);
	alias fp_glIsTransformFeedbackNV = GLboolean function(GLuint);
	alias fp_glPauseTransformFeedbackNV = void function();
	alias fp_glResumeTransformFeedbackNV = void function();
	alias fp_glDrawTransformFeedbackNV = void function(GLenum, GLuint);
	alias fp_glVDPAUInitNV = void function(const(void)*, const(void)*);
	alias fp_glVDPAUFiniNV = void function();
	alias fp_glVDPAURegisterVideoSurfaceNV = GLvdpauSurfaceNV function(const(void)*,
		GLenum, GLsizei, const(GLuint)*);
	alias fp_glVDPAURegisterOutputSurfaceNV = GLvdpauSurfaceNV function(
		const(void)*, GLenum, GLsizei, const(GLuint)*);
	alias fp_glVDPAUIsSurfaceNV = GLboolean function(GLvdpauSurfaceNV);
	alias fp_glVDPAUUnregisterSurfaceNV = void function(GLvdpauSurfaceNV);
	alias fp_glVDPAUGetSurfaceivNV = void function(GLvdpauSurfaceNV, GLenum,
		GLsizei, GLsizei*, GLint*);
	alias fp_glVDPAUSurfaceAccessNV = void function(GLvdpauSurfaceNV, GLenum);
	alias fp_glVDPAUMapSurfacesNV = void function(GLsizei, const(GLvdpauSurfaceNV)*);
	alias fp_glVDPAUUnmapSurfacesNV = void function(GLsizei, const(GLvdpauSurfaceNV)*);
	alias fp_glFlushVertexArrayRangeNV = void function();
	alias fp_glVertexArrayRangeNV = void function(GLsizei, const(void)*);
	alias fp_glVertexAttribL1i64NV = void function(GLuint, GLint64EXT);
	alias fp_glVertexAttribL2i64NV = void function(GLuint, GLint64EXT, GLint64EXT);
	alias fp_glVertexAttribL3i64NV = void function(GLuint, GLint64EXT, GLint64EXT,
		GLint64EXT);
	alias fp_glVertexAttribL4i64NV = void function(GLuint, GLint64EXT,
		GLint64EXT, GLint64EXT, GLint64EXT);
	alias fp_glVertexAttribL1i64vNV = void function(GLuint, const(GLint64EXT)*);
	alias fp_glVertexAttribL2i64vNV = void function(GLuint, const(GLint64EXT)*);
	alias fp_glVertexAttribL3i64vNV = void function(GLuint, const(GLint64EXT)*);
	alias fp_glVertexAttribL4i64vNV = void function(GLuint, const(GLint64EXT)*);
	alias fp_glVertexAttribL1ui64NV = void function(GLuint, GLuint64EXT);
	alias fp_glVertexAttribL2ui64NV = void function(GLuint, GLuint64EXT, GLuint64EXT);
	alias fp_glVertexAttribL3ui64NV = void function(GLuint, GLuint64EXT, GLuint64EXT,
		GLuint64EXT);
	alias fp_glVertexAttribL4ui64NV = void function(GLuint, GLuint64EXT,
		GLuint64EXT, GLuint64EXT, GLuint64EXT);
	alias fp_glVertexAttribL1ui64vNV = void function(GLuint, const(GLuint64EXT)*);
	alias fp_glVertexAttribL2ui64vNV = void function(GLuint, const(GLuint64EXT)*);
	alias fp_glVertexAttribL3ui64vNV = void function(GLuint, const(GLuint64EXT)*);
	alias fp_glVertexAttribL4ui64vNV = void function(GLuint, const(GLuint64EXT)*);
	alias fp_glGetVertexAttribLi64vNV = void function(GLuint, GLenum, GLint64EXT*);
	alias fp_glGetVertexAttribLui64vNV = void function(GLuint, GLenum, GLuint64EXT*);
	alias fp_glVertexAttribLFormatNV = void function(GLuint, GLint, GLenum, GLsizei);
	alias fp_glBufferAddressRangeNV = void function(GLenum, GLuint, GLuint64EXT, GLsizeiptr);
	alias fp_glVertexFormatNV = void function(GLint, GLenum, GLsizei);
	alias fp_glNormalFormatNV = void function(GLenum, GLsizei);
	alias fp_glColorFormatNV = void function(GLint, GLenum, GLsizei);
	alias fp_glIndexFormatNV = void function(GLenum, GLsizei);
	alias fp_glTexCoordFormatNV = void function(GLint, GLenum, GLsizei);
	alias fp_glEdgeFlagFormatNV = void function(GLsizei);
	alias fp_glSecondaryColorFormatNV = void function(GLint, GLenum, GLsizei);
	alias fp_glFogCoordFormatNV = void function(GLenum, GLsizei);
	alias fp_glVertexAttribFormatNV = void function(GLuint, GLint, GLenum, GLboolean,
		GLsizei);
	alias fp_glVertexAttribIFormatNV = void function(GLuint, GLint, GLenum, GLsizei);
	alias fp_glGetIntegerui64i_vNV = void function(GLenum, GLuint, GLuint64EXT*);
	alias fp_glAreProgramsResidentNV = GLboolean function(GLsizei, const(GLuint)*,
		GLboolean*);
	alias fp_glBindProgramNV = void function(GLenum, GLuint);
	alias fp_glDeleteProgramsNV = void function(GLsizei, const(GLuint)*);
	alias fp_glExecuteProgramNV = void function(GLenum, GLuint, const(GLfloat)*);
	alias fp_glGenProgramsNV = void function(GLsizei, GLuint*);
	alias fp_glGetProgramParameterdvNV = void function(GLenum, GLuint, GLenum, GLdouble*);
	alias fp_glGetProgramParameterfvNV = void function(GLenum, GLuint, GLenum, GLfloat*);
	alias fp_glGetProgramivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glGetProgramStringNV = void function(GLuint, GLenum, GLubyte*);
	alias fp_glGetTrackMatrixivNV = void function(GLenum, GLuint, GLenum, GLint*);
	alias fp_glGetVertexAttribdvNV = void function(GLuint, GLenum, GLdouble*);
	alias fp_glGetVertexAttribfvNV = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetVertexAttribivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVertexAttribPointervNV = void function(GLuint, GLenum, void**);
	alias fp_glIsProgramNV = GLboolean function(GLuint);
	alias fp_glLoadProgramNV = void function(GLenum, GLuint, GLsizei, const(GLubyte)*);
	alias fp_glProgramParameter4dNV = void function(GLenum, GLuint, GLdouble,
		GLdouble, GLdouble, GLdouble);
	alias fp_glProgramParameter4dvNV = void function(GLenum, GLuint, const(GLdouble)*);
	alias fp_glProgramParameter4fNV = void function(GLenum, GLuint, GLfloat,
		GLfloat, GLfloat, GLfloat);
	alias fp_glProgramParameter4fvNV = void function(GLenum, GLuint, const(GLfloat)*);
	alias fp_glProgramParameters4dvNV = void function(GLenum, GLuint, GLsizei, const(GLdouble)*);
	alias fp_glProgramParameters4fvNV = void function(GLenum, GLuint, GLsizei, const(GLfloat)*);
	alias fp_glRequestResidentProgramsNV = void function(GLsizei, const(GLuint)*);
	alias fp_glTrackMatrixNV = void function(GLenum, GLuint, GLenum, GLenum);
	alias fp_glVertexAttribPointerNV = void function(GLuint, GLint, GLenum,
		GLsizei, const(void)*);
	alias fp_glVertexAttrib1dNV = void function(GLuint, GLdouble);
	alias fp_glVertexAttrib1dvNV = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib1fNV = void function(GLuint, GLfloat);
	alias fp_glVertexAttrib1fvNV = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib1sNV = void function(GLuint, GLshort);
	alias fp_glVertexAttrib1svNV = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib2dNV = void function(GLuint, GLdouble, GLdouble);
	alias fp_glVertexAttrib2dvNV = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib2fNV = void function(GLuint, GLfloat, GLfloat);
	alias fp_glVertexAttrib2fvNV = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib2sNV = void function(GLuint, GLshort, GLshort);
	alias fp_glVertexAttrib2svNV = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib3dNV = void function(GLuint, GLdouble, GLdouble, GLdouble);
	alias fp_glVertexAttrib3dvNV = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib3fNV = void function(GLuint, GLfloat, GLfloat, GLfloat);
	alias fp_glVertexAttrib3fvNV = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib3sNV = void function(GLuint, GLshort, GLshort, GLshort);
	alias fp_glVertexAttrib3svNV = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib4dNV = void function(GLuint, GLdouble, GLdouble, GLdouble,
		GLdouble);
	alias fp_glVertexAttrib4dvNV = void function(GLuint, const(GLdouble)*);
	alias fp_glVertexAttrib4fNV = void function(GLuint, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glVertexAttrib4fvNV = void function(GLuint, const(GLfloat)*);
	alias fp_glVertexAttrib4sNV = void function(GLuint, GLshort, GLshort, GLshort,
		GLshort);
	alias fp_glVertexAttrib4svNV = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttrib4ubNV = void function(GLuint, GLubyte, GLubyte, GLubyte,
		GLubyte);
	alias fp_glVertexAttrib4ubvNV = void function(GLuint, const(GLubyte)*);
	alias fp_glVertexAttribs1dvNV = void function(GLuint, GLsizei, const(GLdouble)*);
	alias fp_glVertexAttribs1fvNV = void function(GLuint, GLsizei, const(GLfloat)*);
	alias fp_glVertexAttribs1svNV = void function(GLuint, GLsizei, const(GLshort)*);
	alias fp_glVertexAttribs2dvNV = void function(GLuint, GLsizei, const(GLdouble)*);
	alias fp_glVertexAttribs2fvNV = void function(GLuint, GLsizei, const(GLfloat)*);
	alias fp_glVertexAttribs2svNV = void function(GLuint, GLsizei, const(GLshort)*);
	alias fp_glVertexAttribs3dvNV = void function(GLuint, GLsizei, const(GLdouble)*);
	alias fp_glVertexAttribs3fvNV = void function(GLuint, GLsizei, const(GLfloat)*);
	alias fp_glVertexAttribs3svNV = void function(GLuint, GLsizei, const(GLshort)*);
	alias fp_glVertexAttribs4dvNV = void function(GLuint, GLsizei, const(GLdouble)*);
	alias fp_glVertexAttribs4fvNV = void function(GLuint, GLsizei, const(GLfloat)*);
	alias fp_glVertexAttribs4svNV = void function(GLuint, GLsizei, const(GLshort)*);
	alias fp_glVertexAttribs4ubvNV = void function(GLuint, GLsizei, const(GLubyte)*);
	alias fp_glVertexAttribI1iEXT = void function(GLuint, GLint);
	alias fp_glVertexAttribI2iEXT = void function(GLuint, GLint, GLint);
	alias fp_glVertexAttribI3iEXT = void function(GLuint, GLint, GLint, GLint);
	alias fp_glVertexAttribI4iEXT = void function(GLuint, GLint, GLint, GLint, GLint);
	alias fp_glVertexAttribI1uiEXT = void function(GLuint, GLuint);
	alias fp_glVertexAttribI2uiEXT = void function(GLuint, GLuint, GLuint);
	alias fp_glVertexAttribI3uiEXT = void function(GLuint, GLuint, GLuint, GLuint);
	alias fp_glVertexAttribI4uiEXT = void function(GLuint, GLuint, GLuint, GLuint,
		GLuint);
	alias fp_glVertexAttribI1ivEXT = void function(GLuint, const(GLint)*);
	alias fp_glVertexAttribI2ivEXT = void function(GLuint, const(GLint)*);
	alias fp_glVertexAttribI3ivEXT = void function(GLuint, const(GLint)*);
	alias fp_glVertexAttribI4ivEXT = void function(GLuint, const(GLint)*);
	alias fp_glVertexAttribI1uivEXT = void function(GLuint, const(GLuint)*);
	alias fp_glVertexAttribI2uivEXT = void function(GLuint, const(GLuint)*);
	alias fp_glVertexAttribI3uivEXT = void function(GLuint, const(GLuint)*);
	alias fp_glVertexAttribI4uivEXT = void function(GLuint, const(GLuint)*);
	alias fp_glVertexAttribI4bvEXT = void function(GLuint, const(GLbyte)*);
	alias fp_glVertexAttribI4svEXT = void function(GLuint, const(GLshort)*);
	alias fp_glVertexAttribI4ubvEXT = void function(GLuint, const(GLubyte)*);
	alias fp_glVertexAttribI4usvEXT = void function(GLuint, const(GLushort)*);
	alias fp_glVertexAttribIPointerEXT = void function(GLuint, GLint, GLenum,
		GLsizei, const(void)*);
	alias fp_glGetVertexAttribIivEXT = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVertexAttribIuivEXT = void function(GLuint, GLenum, GLuint*);
	alias fp_glBeginVideoCaptureNV = void function(GLuint);
	alias fp_glBindVideoCaptureStreamBufferNV = void function(GLuint, GLuint, GLenum,
		GLintptrARB);
	alias fp_glBindVideoCaptureStreamTextureNV = void function(GLuint, GLuint,
		GLenum, GLenum, GLuint);
	alias fp_glEndVideoCaptureNV = void function(GLuint);
	alias fp_glGetVideoCaptureivNV = void function(GLuint, GLenum, GLint*);
	alias fp_glGetVideoCaptureStreamivNV = void function(GLuint, GLuint, GLenum, GLint*);
	alias fp_glGetVideoCaptureStreamfvNV = void function(GLuint, GLuint, GLenum, GLfloat*);
	alias fp_glGetVideoCaptureStreamdvNV = void function(GLuint, GLuint, GLenum, GLdouble*);
	alias fp_glVideoCaptureNV = GLenum function(GLuint, GLuint*, GLuint64EXT*);
	alias fp_glVideoCaptureStreamParameterivNV = void function(GLuint, GLuint,
		GLenum, const(GLint)*);
	alias fp_glVideoCaptureStreamParameterfvNV = void function(GLuint, GLuint,
		GLenum, const(GLfloat)*);
	alias fp_glVideoCaptureStreamParameterdvNV = void function(GLuint, GLuint,
		GLenum, const(GLdouble)*);
	alias fp_glMultiTexCoord1bOES = void function(GLenum, GLbyte);
	alias fp_glMultiTexCoord1bvOES = void function(GLenum, const(GLbyte)*);
	alias fp_glMultiTexCoord2bOES = void function(GLenum, GLbyte, GLbyte);
	alias fp_glMultiTexCoord2bvOES = void function(GLenum, const(GLbyte)*);
	alias fp_glMultiTexCoord3bOES = void function(GLenum, GLbyte, GLbyte, GLbyte);
	alias fp_glMultiTexCoord3bvOES = void function(GLenum, const(GLbyte)*);
	alias fp_glMultiTexCoord4bOES = void function(GLenum, GLbyte, GLbyte, GLbyte, GLbyte);
	alias fp_glMultiTexCoord4bvOES = void function(GLenum, const(GLbyte)*);
	alias fp_glTexCoord1bOES = void function(GLbyte);
	alias fp_glTexCoord1bvOES = void function(const(GLbyte)*);
	alias fp_glTexCoord2bOES = void function(GLbyte, GLbyte);
	alias fp_glTexCoord2bvOES = void function(const(GLbyte)*);
	alias fp_glTexCoord3bOES = void function(GLbyte, GLbyte, GLbyte);
	alias fp_glTexCoord3bvOES = void function(const(GLbyte)*);
	alias fp_glTexCoord4bOES = void function(GLbyte, GLbyte, GLbyte, GLbyte);
	alias fp_glTexCoord4bvOES = void function(const(GLbyte)*);
	alias fp_glVertex2bOES = void function(GLbyte, GLbyte);
	alias fp_glVertex2bvOES = void function(const(GLbyte)*);
	alias fp_glVertex3bOES = void function(GLbyte, GLbyte, GLbyte);
	alias fp_glVertex3bvOES = void function(const(GLbyte)*);
	alias fp_glVertex4bOES = void function(GLbyte, GLbyte, GLbyte, GLbyte);
	alias fp_glVertex4bvOES = void function(const(GLbyte)*);
	alias fp_glAlphaFuncxOES = void function(GLenum, GLfixed);
	alias fp_glClearColorxOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glClearDepthxOES = void function(GLfixed);
	alias fp_glClipPlanexOES = void function(GLenum, const(GLfixed)*);
	alias fp_glColor4xOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glDepthRangexOES = void function(GLfixed, GLfixed);
	alias fp_glFogxOES = void function(GLenum, GLfixed);
	alias fp_glFogxvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glFrustumxOES = void function(GLfixed, GLfixed, GLfixed, GLfixed, GLfixed,
		GLfixed);
	alias fp_glGetClipPlanexOES = void function(GLenum, GLfixed*);
	alias fp_glGetFixedvOES = void function(GLenum, GLfixed*);
	alias fp_glGetTexEnvxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetTexParameterxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glLightModelxOES = void function(GLenum, GLfixed);
	alias fp_glLightModelxvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glLightxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glLightxvOES = void function(GLenum, GLenum, const(GLfixed)*);
	alias fp_glLineWidthxOES = void function(GLfixed);
	alias fp_glLoadMatrixxOES = void function(const(GLfixed)*);
	alias fp_glMaterialxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glMaterialxvOES = void function(GLenum, GLenum, const(GLfixed)*);
	alias fp_glMultMatrixxOES = void function(const(GLfixed)*);
	alias fp_glMultiTexCoord4xOES = void function(GLenum, GLfixed, GLfixed, GLfixed,
		GLfixed);
	alias fp_glNormal3xOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glOrthoxOES = void function(GLfixed, GLfixed, GLfixed, GLfixed, GLfixed,
		GLfixed);
	alias fp_glPointParameterxvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glPointSizexOES = void function(GLfixed);
	alias fp_glPolygonOffsetxOES = void function(GLfixed, GLfixed);
	alias fp_glRotatexOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glScalexOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glTexEnvxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glTexEnvxvOES = void function(GLenum, GLenum, const(GLfixed)*);
	alias fp_glTexParameterxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glTexParameterxvOES = void function(GLenum, GLenum, const(GLfixed)*);
	alias fp_glTranslatexOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glGetLightxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetMaterialxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glPointParameterxOES = void function(GLenum, GLfixed);
	alias fp_glSampleCoveragexOES = void function(GLclampx, GLboolean);
	alias fp_glAccumxOES = void function(GLenum, GLfixed);
	alias fp_glBitmapxOES = void function(GLsizei, GLsizei, GLfixed, GLfixed,
		GLfixed, GLfixed, const(GLubyte)*);
	alias fp_glBlendColorxOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glClearAccumxOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glColor3xOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glColor3xvOES = void function(const(GLfixed)*);
	alias fp_glColor4xvOES = void function(const(GLfixed)*);
	alias fp_glConvolutionParameterxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glConvolutionParameterxvOES = void function(GLenum, GLenum, const(GLfixed)*);
	alias fp_glEvalCoord1xOES = void function(GLfixed);
	alias fp_glEvalCoord1xvOES = void function(const(GLfixed)*);
	alias fp_glEvalCoord2xOES = void function(GLfixed, GLfixed);
	alias fp_glEvalCoord2xvOES = void function(const(GLfixed)*);
	alias fp_glFeedbackBufferxOES = void function(GLsizei, GLenum, const(GLfixed)*);
	alias fp_glGetConvolutionParameterxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetHistogramParameterxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetLightxOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetMapxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetMaterialxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glGetPixelMapxv = void function(GLenum, GLint, GLfixed*);
	alias fp_glGetTexGenxvOES = void function(GLenum, GLenum, GLfixed*);
	alias fp_glGetTexLevelParameterxvOES = void function(GLenum, GLint, GLenum, GLfixed*);
	alias fp_glIndexxOES = void function(GLfixed);
	alias fp_glIndexxvOES = void function(const(GLfixed)*);
	alias fp_glLoadTransposeMatrixxOES = void function(const(GLfixed)*);
	alias fp_glMap1xOES = void function(GLenum, GLfixed, GLfixed, GLint, GLint, GLfixed);
	alias fp_glMap2xOES = void function(GLenum, GLfixed, GLfixed, GLint, GLint,
		GLfixed, GLfixed, GLint, GLint, GLfixed);
	alias fp_glMapGrid1xOES = void function(GLint, GLfixed, GLfixed);
	alias fp_glMapGrid2xOES = void function(GLint, GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glMultTransposeMatrixxOES = void function(const(GLfixed)*);
	alias fp_glMultiTexCoord1xOES = void function(GLenum, GLfixed);
	alias fp_glMultiTexCoord1xvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glMultiTexCoord2xOES = void function(GLenum, GLfixed, GLfixed);
	alias fp_glMultiTexCoord2xvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glMultiTexCoord3xOES = void function(GLenum, GLfixed, GLfixed, GLfixed);
	alias fp_glMultiTexCoord3xvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glMultiTexCoord4xvOES = void function(GLenum, const(GLfixed)*);
	alias fp_glNormal3xvOES = void function(const(GLfixed)*);
	alias fp_glPassThroughxOES = void function(GLfixed);
	alias fp_glPixelMapx = void function(GLenum, GLint, const(GLfixed)*);
	alias fp_glPixelStorex = void function(GLenum, GLfixed);
	alias fp_glPixelTransferxOES = void function(GLenum, GLfixed);
	alias fp_glPixelZoomxOES = void function(GLfixed, GLfixed);
	alias fp_glPrioritizeTexturesxOES = void function(GLsizei, const(GLuint)*, const(GLfixed)*);
	alias fp_glRasterPos2xOES = void function(GLfixed, GLfixed);
	alias fp_glRasterPos2xvOES = void function(const(GLfixed)*);
	alias fp_glRasterPos3xOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glRasterPos3xvOES = void function(const(GLfixed)*);
	alias fp_glRasterPos4xOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glRasterPos4xvOES = void function(const(GLfixed)*);
	alias fp_glRectxOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glRectxvOES = void function(const(GLfixed)*, const(GLfixed)*);
	alias fp_glTexCoord1xOES = void function(GLfixed);
	alias fp_glTexCoord1xvOES = void function(const(GLfixed)*);
	alias fp_glTexCoord2xOES = void function(GLfixed, GLfixed);
	alias fp_glTexCoord2xvOES = void function(const(GLfixed)*);
	alias fp_glTexCoord3xOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glTexCoord3xvOES = void function(const(GLfixed)*);
	alias fp_glTexCoord4xOES = void function(GLfixed, GLfixed, GLfixed, GLfixed);
	alias fp_glTexCoord4xvOES = void function(const(GLfixed)*);
	alias fp_glTexGenxOES = void function(GLenum, GLenum, GLfixed);
	alias fp_glTexGenxvOES = void function(GLenum, GLenum, const(GLfixed)*);
	alias fp_glVertex2xOES = void function(GLfixed);
	alias fp_glVertex2xvOES = void function(const(GLfixed)*);
	alias fp_glVertex3xOES = void function(GLfixed, GLfixed);
	alias fp_glVertex3xvOES = void function(const(GLfixed)*);
	alias fp_glVertex4xOES = void function(GLfixed, GLfixed, GLfixed);
	alias fp_glVertex4xvOES = void function(const(GLfixed)*);
	alias fp_glQueryMatrixxOES = GLbitfield function(GLfixed*, GLint*);
	alias fp_glClearDepthfOES = void function(GLclampf);
	alias fp_glClipPlanefOES = void function(GLenum, const(GLfloat)*);
	alias fp_glDepthRangefOES = void function(GLclampf, GLclampf);
	alias fp_glFrustumfOES = void function(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glGetClipPlanefOES = void function(GLenum, GLfloat*);
	alias fp_glOrthofOES = void function(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glFramebufferTextureMultiviewOVR = void function(GLenum, GLenum,
		GLuint, GLint, GLint, GLsizei);
	alias fp_glHintPGI = void function(GLenum, GLint);
	alias fp_glDetailTexFuncSGIS = void function(GLenum, GLsizei, const(GLfloat)*);
	alias fp_glGetDetailTexFuncSGIS = void function(GLenum, GLfloat*);
	alias fp_glFogFuncSGIS = void function(GLsizei, const(GLfloat)*);
	alias fp_glGetFogFuncSGIS = void function(GLfloat*);
	alias fp_glSampleMaskSGIS = void function(GLclampf, GLboolean);
	alias fp_glSamplePatternSGIS = void function(GLenum);
	alias fp_glPixelTexGenParameteriSGIS = void function(GLenum, GLint);
	alias fp_glPixelTexGenParameterivSGIS = void function(GLenum, const(GLint)*);
	alias fp_glPixelTexGenParameterfSGIS = void function(GLenum, GLfloat);
	alias fp_glPixelTexGenParameterfvSGIS = void function(GLenum, const(GLfloat)*);
	alias fp_glGetPixelTexGenParameterivSGIS = void function(GLenum, GLint*);
	alias fp_glGetPixelTexGenParameterfvSGIS = void function(GLenum, GLfloat*);
	alias fp_glPointParameterfSGIS = void function(GLenum, GLfloat);
	alias fp_glPointParameterfvSGIS = void function(GLenum, const(GLfloat)*);
	alias fp_glSharpenTexFuncSGIS = void function(GLenum, GLsizei, const(GLfloat)*);
	alias fp_glGetSharpenTexFuncSGIS = void function(GLenum, GLfloat*);
	alias fp_glTexImage4DSGIS = void function(GLenum, GLint, GLenum, GLsizei,
		GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, const(void)*);
	alias fp_glTexSubImage4DSGIS = void function(GLenum, GLint, GLint, GLint,
		GLint, GLint, GLsizei, GLsizei, GLsizei, GLsizei, GLenum, GLenum, const(void)*);
	alias fp_glTextureColorMaskSGIS = void function(GLboolean, GLboolean, GLboolean,
		GLboolean);
	alias fp_glGetTexFilterFuncSGIS = void function(GLenum, GLenum, GLfloat*);
	alias fp_glTexFilterFuncSGIS = void function(GLenum, GLenum, GLsizei, const(GLfloat)*);
	alias fp_glAsyncMarkerSGIX = void function(GLuint);
	alias fp_glFinishAsyncSGIX = GLint function(GLuint*);
	alias fp_glPollAsyncSGIX = GLint function(GLuint*);
	alias fp_glGenAsyncMarkersSGIX = GLuint function(GLsizei);
	alias fp_glDeleteAsyncMarkersSGIX = void function(GLuint, GLsizei);
	alias fp_glIsAsyncMarkerSGIX = GLboolean function(GLuint);
	alias fp_glFlushRasterSGIX = void function();
	alias fp_glFragmentColorMaterialSGIX = void function(GLenum, GLenum);
	alias fp_glFragmentLightfSGIX = void function(GLenum, GLenum, GLfloat);
	alias fp_glFragmentLightfvSGIX = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glFragmentLightiSGIX = void function(GLenum, GLenum, GLint);
	alias fp_glFragmentLightivSGIX = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glFragmentLightModelfSGIX = void function(GLenum, GLfloat);
	alias fp_glFragmentLightModelfvSGIX = void function(GLenum, const(GLfloat)*);
	alias fp_glFragmentLightModeliSGIX = void function(GLenum, GLint);
	alias fp_glFragmentLightModelivSGIX = void function(GLenum, const(GLint)*);
	alias fp_glFragmentMaterialfSGIX = void function(GLenum, GLenum, GLfloat);
	alias fp_glFragmentMaterialfvSGIX = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glFragmentMaterialiSGIX = void function(GLenum, GLenum, GLint);
	alias fp_glFragmentMaterialivSGIX = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glGetFragmentLightfvSGIX = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetFragmentLightivSGIX = void function(GLenum, GLenum, GLint*);
	alias fp_glGetFragmentMaterialfvSGIX = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetFragmentMaterialivSGIX = void function(GLenum, GLenum, GLint*);
	alias fp_glLightEnviSGIX = void function(GLenum, GLint);
	alias fp_glFrameZoomSGIX = void function(GLint);
	alias fp_glIglooInterfaceSGIX = void function(GLenum, const(void)*);
	alias fp_glGetInstrumentsSGIX = GLint function();
	alias fp_glInstrumentsBufferSGIX = void function(GLsizei, GLint*);
	alias fp_glPollInstrumentsSGIX = GLint function(GLint*);
	alias fp_glReadInstrumentsSGIX = void function(GLint);
	alias fp_glStartInstrumentsSGIX = void function();
	alias fp_glStopInstrumentsSGIX = void function(GLint);
	alias fp_glGetListParameterfvSGIX = void function(GLuint, GLenum, GLfloat*);
	alias fp_glGetListParameterivSGIX = void function(GLuint, GLenum, GLint*);
	alias fp_glListParameterfSGIX = void function(GLuint, GLenum, GLfloat);
	alias fp_glListParameterfvSGIX = void function(GLuint, GLenum, const(GLfloat)*);
	alias fp_glListParameteriSGIX = void function(GLuint, GLenum, GLint);
	alias fp_glListParameterivSGIX = void function(GLuint, GLenum, const(GLint)*);
	alias fp_glPixelTexGenSGIX = void function(GLenum);
	alias fp_glDeformationMap3dSGIX = void function(GLenum, GLdouble, GLdouble,
		GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble,
		GLint, GLint, const(GLdouble)*);
	alias fp_glDeformationMap3fSGIX = void function(GLenum, GLfloat, GLfloat,
		GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint,
		GLint, const(GLfloat)*);
	alias fp_glDeformSGIX = void function(GLbitfield);
	alias fp_glLoadIdentityDeformationMapSGIX = void function(GLbitfield);
	alias fp_glReferencePlaneSGIX = void function(const(GLdouble)*);
	alias fp_glSpriteParameterfSGIX = void function(GLenum, GLfloat);
	alias fp_glSpriteParameterfvSGIX = void function(GLenum, const(GLfloat)*);
	alias fp_glSpriteParameteriSGIX = void function(GLenum, GLint);
	alias fp_glSpriteParameterivSGIX = void function(GLenum, const(GLint)*);
	alias fp_glTagSampleBufferSGIX = void function();
	alias fp_glColorTableSGI = void function(GLenum, GLenum, GLsizei, GLenum,
		GLenum, const(void)*);
	alias fp_glColorTableParameterfvSGI = void function(GLenum, GLenum, const(GLfloat)*);
	alias fp_glColorTableParameterivSGI = void function(GLenum, GLenum, const(GLint)*);
	alias fp_glCopyColorTableSGI = void function(GLenum, GLenum, GLint, GLint, GLsizei);
	alias fp_glGetColorTableSGI = void function(GLenum, GLenum, GLenum, void*);
	alias fp_glGetColorTableParameterfvSGI = void function(GLenum, GLenum, GLfloat*);
	alias fp_glGetColorTableParameterivSGI = void function(GLenum, GLenum, GLint*);
	alias fp_glFinishTextureSUNX = void function();
	alias fp_glGlobalAlphaFactorbSUN = void function(GLbyte);
	alias fp_glGlobalAlphaFactorsSUN = void function(GLshort);
	alias fp_glGlobalAlphaFactoriSUN = void function(GLint);
	alias fp_glGlobalAlphaFactorfSUN = void function(GLfloat);
	alias fp_glGlobalAlphaFactordSUN = void function(GLdouble);
	alias fp_glGlobalAlphaFactorubSUN = void function(GLubyte);
	alias fp_glGlobalAlphaFactorusSUN = void function(GLushort);
	alias fp_glGlobalAlphaFactoruiSUN = void function(GLuint);
	alias fp_glDrawMeshArraysSUN = void function(GLenum, GLint, GLsizei, GLsizei);
	alias fp_glReplacementCodeuiSUN = void function(GLuint);
	alias fp_glReplacementCodeusSUN = void function(GLushort);
	alias fp_glReplacementCodeubSUN = void function(GLubyte);
	alias fp_glReplacementCodeuivSUN = void function(const(GLuint)*);
	alias fp_glReplacementCodeusvSUN = void function(const(GLushort)*);
	alias fp_glReplacementCodeubvSUN = void function(const(GLubyte)*);
	alias fp_glReplacementCodePointerSUN = void function(GLenum, GLsizei, const(void*)*);
	alias fp_glColor4ubVertex2fSUN = void function(GLubyte, GLubyte, GLubyte,
		GLubyte, GLfloat, GLfloat);
	alias fp_glColor4ubVertex2fvSUN = void function(const(GLubyte)*, const(GLfloat)*);
	alias fp_glColor4ubVertex3fSUN = void function(GLubyte, GLubyte, GLubyte,
		GLubyte, GLfloat, GLfloat, GLfloat);
	alias fp_glColor4ubVertex3fvSUN = void function(const(GLubyte)*, const(GLfloat)*);
	alias fp_glColor3fVertex3fSUN = void function(GLfloat, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat);
	alias fp_glColor3fVertex3fvSUN = void function(const(GLfloat)*, const(GLfloat)*);
	alias fp_glNormal3fVertex3fSUN = void function(GLfloat, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat);
	alias fp_glNormal3fVertex3fvSUN = void function(const(GLfloat)*, const(GLfloat)*);
	alias fp_glColor4fNormal3fVertex3fSUN = void function(GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glColor4fNormal3fVertex3fvSUN = void function(const(GLfloat)*,
		const(GLfloat)*, const(GLfloat)*);
	alias fp_glTexCoord2fVertex3fSUN = void function(GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glTexCoord2fVertex3fvSUN = void function(const(GLfloat)*, const(GLfloat)*);
	alias fp_glTexCoord4fVertex4fSUN = void function(GLfloat, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glTexCoord4fVertex4fvSUN = void function(const(GLfloat)*, const(GLfloat)*);
	alias fp_glTexCoord2fColor4ubVertex3fSUN = void function(GLfloat, GLfloat,
		GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
	alias fp_glTexCoord2fColor4ubVertex3fvSUN = void function(const(GLfloat)*,
		const(GLubyte)*, const(GLfloat)*);
	alias fp_glTexCoord2fColor3fVertex3fSUN = void function(GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glTexCoord2fColor3fVertex3fvSUN = void function(const(GLfloat)*,
		const(GLfloat)*, const(GLfloat)*);
	alias fp_glTexCoord2fNormal3fVertex3fSUN = void function(GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glTexCoord2fNormal3fVertex3fvSUN = void function(const(GLfloat)*,
		const(GLfloat)*, const(GLfloat)*);
	alias fp_glTexCoord2fColor4fNormal3fVertex3fSUN = void function(GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat);
	alias fp_glTexCoord2fColor4fNormal3fVertex3fvSUN = void function(
		const(GLfloat)*, const(GLfloat)*, const(GLfloat)*, const(GLfloat)*);
	alias fp_glTexCoord4fColor4fNormal3fVertex4fSUN = void function(GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glTexCoord4fColor4fNormal3fVertex4fvSUN = void function(
		const(GLfloat)*, const(GLfloat)*, const(GLfloat)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiVertex3fSUN = void function(GLuint, GLfloat, GLfloat,
		GLfloat);
	alias fp_glReplacementCodeuiVertex3fvSUN = void function(const(GLuint)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiColor4ubVertex3fSUN = void function(GLuint,
		GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
	alias fp_glReplacementCodeuiColor4ubVertex3fvSUN = void function(const(GLuint)*,
		const(GLubyte)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiColor3fVertex3fSUN = void function(GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glReplacementCodeuiColor3fVertex3fvSUN = void function(const(GLuint)*,
		const(GLfloat)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiNormal3fVertex3fSUN = void function(GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glReplacementCodeuiNormal3fVertex3fvSUN = void function(const(GLuint)*,
		const(GLfloat)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiColor4fNormal3fVertex3fSUN = void function(GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat);
	alias fp_glReplacementCodeuiColor4fNormal3fVertex3fvSUN = void function(
		const(GLuint)*, const(GLfloat)*, const(GLfloat)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiTexCoord2fVertex3fSUN = void function(GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glReplacementCodeuiTexCoord2fVertex3fvSUN = void function(
		const(GLuint)*, const(GLfloat)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN = void function(GLuint,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN = void function(
		const(GLuint)*, const(GLfloat)*, const(GLfloat)*, const(GLfloat)*);
	alias fp_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN = void function(
		GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat,
		GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
	alias fp_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN = void function(
		const(GLuint)*, const(GLfloat)*, const(GLfloat)*, const(GLfloat)*, const(GLfloat)*);
}
__gshared
{
	fp_glMultiDrawArraysIndirectBindlessCountNV glMultiDrawArraysIndirectBindlessCountNV;
	fp_glTextureParameterfv glTextureParameterfv;
	fp_glGetListParameterivSGIX glGetListParameterivSGIX;
	fp_glProgramUniform1i64ARB glProgramUniform1i64ARB;
	fp_glVertexArrayElementBuffer glVertexArrayElementBuffer;
	fp_glHintPGI glHintPGI;
	fp_glGetFramebufferAttachmentParameterivEXT glGetFramebufferAttachmentParameterivEXT;
	fp_glTextureStorage3DMultisample glTextureStorage3DMultisample;
	fp_glGetIntegerIndexedvEXT glGetIntegerIndexedvEXT;
	fp_glUniform2ui64NV glUniform2ui64NV;
	fp_glTexRenderbufferNV glTexRenderbufferNV;
	fp_glVertexAttrib3hvNV glVertexAttrib3hvNV;
	fp_glProgramUniform4ui64ARB glProgramUniform4ui64ARB;
	fp_glInstrumentsBufferSGIX glInstrumentsBufferSGIX;
	fp_glMultiTexCoord2sARB glMultiTexCoord2sARB;
	fp_glProgramEnvParameter4fARB glProgramEnvParameter4fARB;
	fp_glSecondaryColor3hvNV glSecondaryColor3hvNV;
	fp_glFrustumxOES glFrustumxOES;
	fp_glTextureStorage3DEXT glTextureStorage3DEXT;
	fp_glUniform4uiEXT glUniform4uiEXT;
	fp_glProgramUniform3ui64ARB glProgramUniform3ui64ARB;
	fp_glVertexArrayBindVertexBufferEXT glVertexArrayBindVertexBufferEXT;
	fp_glUniform3uiEXT glUniform3uiEXT;
	fp_glVertexAttribI3uivEXT glVertexAttribI3uivEXT;
	fp_glTransformFeedbackBufferRange glTransformFeedbackBufferRange;
	fp_glGetProgramPipelineivEXT glGetProgramPipelineivEXT;
	fp_glPathGlyphsNV glPathGlyphsNV;
	fp_glGetCombinerInputParameterivNV glGetCombinerInputParameterivNV;
	fp_glEndPerfMonitorAMD glEndPerfMonitorAMD;
	fp_glPointParameterfvARB glPointParameterfvARB;
	fp_glVertex2xOES glVertex2xOES;
	fp_glDrawElementsInstancedBaseInstance glDrawElementsInstancedBaseInstance;
	fp_glMultTransposeMatrixdARB glMultTransposeMatrixdARB;
	fp_glVertexAttribL4dEXT glVertexAttribL4dEXT;
	fp_glGetTextureParameterivEXT glGetTextureParameterivEXT;
	fp_glCoverStrokePathInstancedNV glCoverStrokePathInstancedNV;
	fp_glDeformSGIX glDeformSGIX;
	fp_glCopyPathNV glCopyPathNV;
	fp_glEndFragmentShaderATI glEndFragmentShaderATI;
	fp_glCompressedMultiTexSubImage3DEXT glCompressedMultiTexSubImage3DEXT;
	fp_glVDPAURegisterOutputSurfaceNV glVDPAURegisterOutputSurfaceNV;
	fp_glProgramUniform4fEXT glProgramUniform4fEXT;
	fp_glCoverStrokePathNV glCoverStrokePathNV;
	fp_glTextureImage2DMultisampleNV glTextureImage2DMultisampleNV;
	fp_glVertex3bOES glVertex3bOES;
	fp_glTessellationFactorAMD glTessellationFactorAMD;
	fp_glDebugMessageControl glDebugMessageControl;
	fp_glIsObjectBufferATI glIsObjectBufferATI;
	fp_glProgramUniform4iEXT glProgramUniform4iEXT;
	fp_glVertexAttrib2svARB glVertexAttrib2svARB;
	fp_glMinSampleShadingARB glMinSampleShadingARB;
	fp_glSpriteParameteriSGIX glSpriteParameteriSGIX;
	fp_glFragmentMaterialfSGIX glFragmentMaterialfSGIX;
	fp_glVDPAUGetSurfaceivNV glVDPAUGetSurfaceivNV;
	fp_glGetInternalformatSampleivNV glGetInternalformatSampleivNV;
	fp_glVertexAttribs4hvNV glVertexAttribs4hvNV;
	fp_glVertexAttrib4NubvARB glVertexAttrib4NubvARB;
	fp_glMultiTexCoord3hvNV glMultiTexCoord3hvNV;
	fp_glMatrixPushEXT glMatrixPushEXT;
	fp_glProgramUniform2fEXT glProgramUniform2fEXT;
	fp_glMultiDrawElementsIndirectBindlessNV glMultiDrawElementsIndirectBindlessNV;
	fp_glProgramUniform3f glProgramUniform3f;
	fp_glObjectPtrLabelKHR glObjectPtrLabelKHR;
	fp_glVertexAttribL4d glVertexAttribL4d;
	fp_glGetFragmentMaterialfvSGIX glGetFragmentMaterialfvSGIX;
	fp_glGetProgramLocalParameterIuivNV glGetProgramLocalParameterIuivNV;
	fp_glGetTexEnvxvOES glGetTexEnvxvOES;
	fp_glUniformMatrix3dv glUniformMatrix3dv;
	fp_glGetVertexAttribLdvEXT glGetVertexAttribLdvEXT;
	fp_glGetVertexArrayIndexediv glGetVertexArrayIndexediv;
	fp_glResumeTransformFeedback glResumeTransformFeedback;
	fp_glInsertEventMarkerEXT glInsertEventMarkerEXT;
	fp_glTessellationModeAMD glTessellationModeAMD;
	fp_glFinishAsyncSGIX glFinishAsyncSGIX;
	fp_glBeginVertexShaderEXT glBeginVertexShaderEXT;
	fp_glGetMultiTexParameterivEXT glGetMultiTexParameterivEXT;
	fp_glProgramUniformMatrix3x4fvEXT glProgramUniformMatrix3x4fvEXT;
	fp_glUniform1ui64vARB glUniform1ui64vARB;
	fp_glLoadProgramNV glLoadProgramNV;
	fp_glWriteMaskEXT glWriteMaskEXT;
	fp_glGetGraphicsResetStatus glGetGraphicsResetStatus;
	fp_glImageTransformParameterfvHP glImageTransformParameterfvHP;
	fp_glColor4hNV glColor4hNV;
	fp_glGetFragmentLightfvSGIX glGetFragmentLightfvSGIX;
	fp_glListParameterfSGIX glListParameterfSGIX;
	fp_glMapNamedBufferRange glMapNamedBufferRange;
	fp_glProgramUniform2i64vNV glProgramUniform2i64vNV;
	fp_glFragmentLightModelfSGIX glFragmentLightModelfSGIX;
	fp_glIndexPointerEXT glIndexPointerEXT;
	fp_glVertexArrayAttribIFormat glVertexArrayAttribIFormat;
	fp_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN;
	fp_glReplacementCodeubvSUN glReplacementCodeubvSUN;
	fp_glGetDoubleIndexedvEXT glGetDoubleIndexedvEXT;
	fp_glTexSubImage3DEXT glTexSubImage3DEXT;
	fp_glGetPixelTexGenParameterfvSGIS glGetPixelTexGenParameterfvSGIS;
	fp_glReplacementCodeuiNormal3fVertex3fSUN glReplacementCodeuiNormal3fVertex3fSUN;
	fp_glGetDebugMessageLogAMD glGetDebugMessageLogAMD;
	fp_glVertexStream4sATI glVertexStream4sATI;
	fp_glProgramUniform3uiv glProgramUniform3uiv;
	fp_glGetnMapdvARB glGetnMapdvARB;
	fp_glOrthofOES glOrthofOES;
	fp_glViewportArrayv glViewportArrayv;
	fp_glDrawElementArrayATI glDrawElementArrayATI;
	fp_glGetPathColorGenfvNV glGetPathColorGenfvNV;
	fp_glWindowPos3iMESA glWindowPos3iMESA;
	fp_glColor4ubVertex2fSUN glColor4ubVertex2fSUN;
	fp_glUniform3ui64ARB glUniform3ui64ARB;
	fp_glSecondaryColor3ubvEXT glSecondaryColor3ubvEXT;
	fp_glGetNamedBufferSubDataEXT glGetNamedBufferSubDataEXT;
	fp_glConvolutionFilter2D glConvolutionFilter2D;
	fp_glMemoryBarrierByRegion glMemoryBarrierByRegion;
	fp_glTexCoord2fNormal3fVertex3fSUN glTexCoord2fNormal3fVertex3fSUN;
	fp_glMatrixRotatedEXT glMatrixRotatedEXT;
	fp_glIsProgramNV glIsProgramNV;
	fp_glUniform2dv glUniform2dv;
	fp_glDepthBoundsEXT glDepthBoundsEXT;
	fp_glVertexAttrib4hvNV glVertexAttrib4hvNV;
	fp_glColorFragmentOp1ATI glColorFragmentOp1ATI;
	fp_glVertexBindingDivisor glVertexBindingDivisor;
	fp_glWindowPos3ivMESA glWindowPos3ivMESA;
	fp_glGetnUniformfvARB glGetnUniformfvARB;
	fp_glArrayObjectATI glArrayObjectATI;
	fp_glVertexArrayBindingDivisor glVertexArrayBindingDivisor;
	fp_glProgramUniformMatrix3fv glProgramUniformMatrix3fv;
	fp_glCompileShaderIncludeARB glCompileShaderIncludeARB;
	fp_glVertexStream4svATI glVertexStream4svATI;
	fp_glMultiTexCoord4iARB glMultiTexCoord4iARB;
	fp_glVariantfvEXT glVariantfvEXT;
	fp_glMatrixLoadfEXT glMatrixLoadfEXT;
	fp_glLoadIdentityDeformationMapSGIX glLoadIdentityDeformationMapSGIX;
	fp_glReferencePlaneSGIX glReferencePlaneSGIX;
	fp_glNamedRenderbufferStorage glNamedRenderbufferStorage;
	fp_glFogCoordPointerListIBM glFogCoordPointerListIBM;
	fp_glGetVertexAttribIivEXT glGetVertexAttribIivEXT;
	fp_glFramebufferDrawBuffersEXT glFramebufferDrawBuffersEXT;
	fp_glVertexAttribs4fvNV glVertexAttribs4fvNV;
	fp_glPauseTransformFeedbackNV glPauseTransformFeedbackNV;
	fp_glGetQueryObjecti64vEXT glGetQueryObjecti64vEXT;
	fp_glProgramUniform4uiEXT glProgramUniform4uiEXT;
	fp_glValidateProgramPipeline glValidateProgramPipeline;
	fp_glTexPageCommitmentARB glTexPageCommitmentARB;
	fp_glWindowPos3dvARB glWindowPos3dvARB;
	fp_glStencilStrokePathInstancedNV glStencilStrokePathInstancedNV;
	fp_glColor3hvNV glColor3hvNV;
	fp_glProgramUniform2i64NV glProgramUniform2i64NV;
	fp_glVertexStream1ivATI glVertexStream1ivATI;
	fp_glProgramEnvParameterI4iNV glProgramEnvParameterI4iNV;
	fp_glDrawTransformFeedbackInstanced glDrawTransformFeedbackInstanced;
	fp_glStencilThenCoverStrokePathNV glStencilThenCoverStrokePathNV;
	fp_glDeleteVertexArraysAPPLE glDeleteVertexArraysAPPLE;
	fp_glGetNamedBufferParameterui64vNV glGetNamedBufferParameterui64vNV;
	fp_glQueryMatrixxOES glQueryMatrixxOES;
	fp_glTranslatexOES glTranslatexOES;
	fp_glDrawTransformFeedback glDrawTransformFeedback;
	fp_glTexCoord2fColor4fNormal3fVertex3fvSUN glTexCoord2fColor4fNormal3fVertex3fvSUN;
	fp_glVDPAURegisterVideoSurfaceNV glVDPAURegisterVideoSurfaceNV;
	fp_glVertexStream2iATI glVertexStream2iATI;
	fp_glFragmentLightModeliSGIX glFragmentLightModeliSGIX;
	fp_glListParameteriSGIX glListParameteriSGIX;
	fp_glBlendColorxOES glBlendColorxOES;
	fp_glUniformui64vNV glUniformui64vNV;
	fp_glFramebufferTextureLayerEXT glFramebufferTextureLayerEXT;
	fp_glGetObjectPtrLabel glGetObjectPtrLabel;
	fp_glTextureParameteri glTextureParameteri;
	fp_glTextureParameterf glTextureParameterf;
	fp_glUniformMatrix2x3dv glUniformMatrix2x3dv;
	fp_glFramebufferDrawBufferEXT glFramebufferDrawBufferEXT;
	fp_glCopyColorSubTable glCopyColorSubTable;
	fp_glVertexAttribL3d glVertexAttribL3d;
	fp_glPathParameterfNV glPathParameterfNV;
	fp_glMatrixLoadTranspose3x3fNV glMatrixLoadTranspose3x3fNV;
	fp_glDeleteNamesAMD glDeleteNamesAMD;
	fp_glDrawRangeElementsEXT glDrawRangeElementsEXT;
	fp_glColor4xOES glColor4xOES;
	fp_glGetVertexAttribArrayObjectivATI glGetVertexAttribArrayObjectivATI;
	fp_glProgramUniform1ui glProgramUniform1ui;
	fp_glDeleteBuffersARB glDeleteBuffersARB;
	fp_glUnmapBufferARB glUnmapBufferARB;
	fp_glMaterialxOES glMaterialxOES;
	fp_glProgramUniformMatrix2x4fvEXT glProgramUniformMatrix2x4fvEXT;
	fp_glTestObjectAPPLE glTestObjectAPPLE;
	fp_glRenderbufferStorageEXT glRenderbufferStorageEXT;
	fp_glVertexAttribL1ui64ARB glVertexAttribL1ui64ARB;
	fp_glPathParameterivNV glPathParameterivNV;
	fp_glFrameZoomSGIX glFrameZoomSGIX;
	fp_glSecondaryColor3fEXT glSecondaryColor3fEXT;
	fp_glVertexAttribL1dv glVertexAttribL1dv;
	fp_glNormalStream3svATI glNormalStream3svATI;
	fp_glPathStencilFuncNV glPathStencilFuncNV;
	fp_glSetInvariantEXT glSetInvariantEXT;
	fp_glGetTexBumpParameterivATI glGetTexBumpParameterivATI;
	fp_glIsNamedStringARB glIsNamedStringARB;
	fp_glEndOcclusionQueryNV glEndOcclusionQueryNV;
	fp_glScissorArrayv glScissorArrayv;
	fp_glMapTexture2DINTEL glMapTexture2DINTEL;
	fp_glGetVertexAttribArrayObjectfvATI glGetVertexAttribArrayObjectfvATI;
	fp_glPixelTransferxOES glPixelTransferxOES;
	fp_glGetMultiTexEnvfvEXT glGetMultiTexEnvfvEXT;
	fp_glTagSampleBufferSGIX glTagSampleBufferSGIX;
	fp_glProgramUniformMatrix4dvEXT glProgramUniformMatrix4dvEXT;
	fp_glVertexAttribL2dvEXT glVertexAttribL2dvEXT;
	fp_glGetCombinerStageParameterfvNV glGetCombinerStageParameterfvNV;
	fp_glInvalidateSubFramebuffer glInvalidateSubFramebuffer;
	fp_glVertexAttribLFormat glVertexAttribLFormat;
	fp_glElementPointerAPPLE glElementPointerAPPLE;
	fp_glVertexStream1fATI glVertexStream1fATI;
	fp_glCoverageModulationNV glCoverageModulationNV;
	fp_glGetProgramParameterfvNV glGetProgramParameterfvNV;
	fp_glMaxShaderCompilerThreadsARB glMaxShaderCompilerThreadsARB;
	fp_glUniformMatrix4x2dv glUniformMatrix4x2dv;
	fp_glVertexArrayVertexAttribLOffsetEXT glVertexArrayVertexAttribLOffsetEXT;
	fp_glIsImageHandleResidentNV glIsImageHandleResidentNV;
	fp_glVertexAttribL3i64vNV glVertexAttribL3i64vNV;
	fp_glProgramUniform4iv glProgramUniform4iv;
	fp_glVertexAttrib1dvARB glVertexAttrib1dvARB;
	fp_glTextureSubImage2DEXT glTextureSubImage2DEXT;
	fp_glIsVertexArrayAPPLE glIsVertexArrayAPPLE;
	fp_glMultiTexCoord4fvARB glMultiTexCoord4fvARB;
	fp_glProgramEnvParametersI4uivNV glProgramEnvParametersI4uivNV;
	fp_glImageTransformParameterivHP glImageTransformParameterivHP;
	fp_glUniform3fvARB glUniform3fvARB;
	fp_glProgramUniformMatrix3x2fvEXT glProgramUniformMatrix3x2fvEXT;
	fp_glMultiTexImage1DEXT glMultiTexImage1DEXT;
	fp_glUniform3i64vARB glUniform3i64vARB;
	fp_glTextureLightEXT glTextureLightEXT;
	fp_glMultiTexCoord3dARB glMultiTexCoord3dARB;
	fp_glNamedFramebufferTextureEXT glNamedFramebufferTextureEXT;
	fp_glEvalCoord2xvOES glEvalCoord2xvOES;
	fp_glBindFragDataLocationEXT glBindFragDataLocationEXT;
	fp_glTexImage2DMultisampleCoverageNV glTexImage2DMultisampleCoverageNV;
	fp_glGetAttribLocationARB glGetAttribLocationARB;
	fp_glEndVideoCaptureNV glEndVideoCaptureNV;
	fp_glVertexAttrib1fARB glVertexAttrib1fARB;
	fp_glTexCoord2fColor4ubVertex3fSUN glTexCoord2fColor4ubVertex3fSUN;
	fp_glCopyTextureSubImage1D glCopyTextureSubImage1D;
	fp_glMapParameterfvNV glMapParameterfvNV;
	fp_glTextureParameterIuiv glTextureParameterIuiv;
	fp_glGetMinmaxParameterivEXT glGetMinmaxParameterivEXT;
	fp_glGetVideoi64vNV glGetVideoi64vNV;
	fp_glWindowPos3sARB glWindowPos3sARB;
	fp_glGetConvolutionParameterfv glGetConvolutionParameterfv;
	fp_glTexCoord2xOES glTexCoord2xOES;
	fp_glVertexAttribFormat glVertexAttribFormat;
	fp_glGetProgramivARB glGetProgramivARB;
	fp_glPathGlyphRangeNV glPathGlyphRangeNV;
	fp_glVertexAttribBinding glVertexAttribBinding;
	fp_glGetHistogramParameteriv glGetHistogramParameteriv;
	fp_glFramebufferSampleLocationsfvNV glFramebufferSampleLocationsfvNV;
	fp_glGetNextPerfQueryIdINTEL glGetNextPerfQueryIdINTEL;
	fp_glTextureBufferEXT glTextureBufferEXT;
	fp_glGetMultiTexImageEXT glGetMultiTexImageEXT;
	fp_glGetPathCoordsNV glGetPathCoordsNV;
	fp_glGenProgramPipelines glGenProgramPipelines;
	fp_glBufferParameteriAPPLE glBufferParameteriAPPLE;
	fp_glTexStorageSparseAMD glTexStorageSparseAMD;
	fp_glNamedBufferStorageEXT glNamedBufferStorageEXT;
	fp_glBindImageTextures glBindImageTextures;
	fp_glVertexPointerEXT glVertexPointerEXT;
	fp_glDebugMessageCallbackARB glDebugMessageCallbackARB;
	fp_glGetPathParameterfvNV glGetPathParameterfvNV;
	fp_glLightxvOES glLightxvOES;
	fp_glVertexAttribI4ivEXT glVertexAttribI4ivEXT;
	fp_glPrioritizeTexturesxOES glPrioritizeTexturesxOES;
	fp_glFramebufferParameteri glFramebufferParameteri;
	fp_glTexCoord3hNV glTexCoord3hNV;
	fp_glMultiModeDrawElementsIBM glMultiModeDrawElementsIBM;
	fp_glUniform2iARB glUniform2iARB;
	fp_glColorPointervINTEL glColorPointervINTEL;
	fp_glGetMinmaxParameterfvEXT glGetMinmaxParameterfvEXT;
	fp_glWindowPos3sMESA glWindowPos3sMESA;
	fp_glNamedFramebufferParameteri glNamedFramebufferParameteri;
	fp_glTexCoord2fVertex3fvSUN glTexCoord2fVertex3fvSUN;
	fp_glReplacementCodeusSUN glReplacementCodeusSUN;
	fp_glGetNamedFramebufferParameteriv glGetNamedFramebufferParameteriv;
	fp_glVertexStream1fvATI glVertexStream1fvATI;
	fp_glCreateVertexArrays glCreateVertexArrays;
	fp_glGetArrayObjectfvATI glGetArrayObjectfvATI;
	fp_glVertex4bOES glVertex4bOES;
	fp_glMultiTexCoord3fARB glMultiTexCoord3fARB;
	fp_glGetQueryObjectuivARB glGetQueryObjectuivARB;
	fp_glScalexOES glScalexOES;
	fp_glGetVertexAttribivNV glGetVertexAttribivNV;
	fp_glShaderOp1EXT glShaderOp1EXT;
	fp_glBeginVideoCaptureNV glBeginVideoCaptureNV;
	fp_glUniform1d glUniform1d;
	fp_glClearColorIiEXT glClearColorIiEXT;
	fp_glSetFenceNV glSetFenceNV;
	fp_glColorTableParameterivSGI glColorTableParameterivSGI;
	fp_glDeleteFencesAPPLE glDeleteFencesAPPLE;
	fp_glProgramUniform4i glProgramUniform4i;
	fp_glUniformHandleui64ARB glUniformHandleui64ARB;
	fp_glProgramUniform4f glProgramUniform4f;
	fp_glViewportIndexedf glViewportIndexedf;
	fp_glProgramUniform4d glProgramUniform4d;
	fp_glTexCoord1xOES glTexCoord1xOES;
	fp_glMultiModeDrawArraysIBM glMultiModeDrawArraysIBM;
	fp_glPointAlongPathNV glPointAlongPathNV;
	fp_glEndQueryARB glEndQueryARB;
	fp_glVertexAttrib4svARB glVertexAttrib4svARB;
	fp_glVertexAttrib4uivARB glVertexAttrib4uivARB;
	fp_glResumeTransformFeedbackNV glResumeTransformFeedbackNV;
	fp_glTexCoord2fColor4ubVertex3fvSUN glTexCoord2fColor4ubVertex3fvSUN;
	fp_glMultiTexRenderbufferEXT glMultiTexRenderbufferEXT;
	fp_glGetFogFuncSGIS glGetFogFuncSGIS;
	fp_glUnmapNamedBuffer glUnmapNamedBuffer;
	fp_glTexCoord4bvOES glTexCoord4bvOES;
	fp_glVertexAttrib3fARB glVertexAttrib3fARB;
	fp_glRasterPos2xOES glRasterPos2xOES;
	fp_glColor4ubVertex2fvSUN glColor4ubVertex2fvSUN;
	fp_glDrawTransformFeedbackStreamInstanced glDrawTransformFeedbackStreamInstanced;
	fp_glVertexAttribL3ui64vNV glVertexAttribL3ui64vNV;
	fp_glSpriteParameterfSGIX glSpriteParameterfSGIX;
	fp_glBindVideoCaptureStreamTextureNV glBindVideoCaptureStreamTextureNV;
	fp_glFlushPixelDataRangeNV glFlushPixelDataRangeNV;
	fp_glVertexAttribLFormatNV glVertexAttribLFormatNV;
	fp_glMap2xOES glMap2xOES;
	fp_glGetColorTableSGI glGetColorTableSGI;
	fp_glGetCompressedTexImageARB glGetCompressedTexImageARB;
	fp_glConvolutionParameteri glConvolutionParameteri;
	fp_glVertexWeighthNV glVertexWeighthNV;
	fp_glConvolutionParameterf glConvolutionParameterf;
	fp_glVertexAttribI4ubvEXT glVertexAttribI4ubvEXT;
	fp_glVertexAttrib1dNV glVertexAttrib1dNV;
	fp_glGetnUniformfvKHR glGetnUniformfvKHR;
	fp_glUnmapObjectBufferATI glUnmapObjectBufferATI;
	fp_glNamedProgramLocalParameterI4uiEXT glNamedProgramLocalParameterI4uiEXT;
	fp_glProgramUniform1iEXT glProgramUniform1iEXT;
	fp_glDeleteQueriesARB glDeleteQueriesARB;
	fp_glWindowPos3svARB glWindowPos3svARB;
	fp_glTextureStorage3D glTextureStorage3D;
	fp_glGenPathsNV glGenPathsNV;
	fp_glStringMarkerGREMEDY glStringMarkerGREMEDY;
	fp_glIsTransformFeedback glIsTransformFeedback;
	fp_glProgramUniformMatrix2x3dvEXT glProgramUniformMatrix2x3dvEXT;
	fp_glGetObjectLabelEXT glGetObjectLabelEXT;
	fp_glIsProgramPipeline glIsProgramPipeline;
	fp_glGetNamedProgramStringEXT glGetNamedProgramStringEXT;
	fp_glVertexAttrib4sNV glVertexAttrib4sNV;
	fp_glProgramLocalParameter4dvARB glProgramLocalParameter4dvARB;
	fp_glGetHandleARB glGetHandleARB;
	fp_glFogCoordFormatNV glFogCoordFormatNV;
	fp_glGetnMapfvARB glGetnMapfvARB;
	fp_glGetnUniformfv glGetnUniformfv;
	fp_glVertexAttribL2dv glVertexAttribL2dv;
	fp_glVertexWeightPointerEXT glVertexWeightPointerEXT;
	fp_glTangent3sEXT glTangent3sEXT;
	fp_glGetNamedStringARB glGetNamedStringARB;
	fp_glMatrixMultdEXT glMatrixMultdEXT;
	fp_glVertexAttribL2d glVertexAttribL2d;
	fp_glGetVertexAttribdvNV glGetVertexAttribdvNV;
	fp_glGetQueryBufferObjectiv glGetQueryBufferObjectiv;
	fp_glTexGenxOES glTexGenxOES;
	fp_glLightEnviSGIX glLightEnviSGIX;
	fp_glGetProgramPipelineiv glGetProgramPipelineiv;
	fp_glVertexStream2ivATI glVertexStream2ivATI;
	fp_glGetColorTableEXT glGetColorTableEXT;
	fp_glGetOcclusionQueryuivNV glGetOcclusionQueryuivNV;
	fp_glMultiTexCoord4bOES glMultiTexCoord4bOES;
	fp_glVertexAttribL1i64NV glVertexAttribL1i64NV;
	fp_glVDPAUInitNV glVDPAUInitNV;
	fp_glVertexAttrib1hvNV glVertexAttrib1hvNV;
	fp_glGetIntegerui64i_vNV glGetIntegerui64i_vNV;
	fp_glEdgeFlagFormatNV glEdgeFlagFormatNV;
	fp_glUniformHandleui64NV glUniformHandleui64NV;
	fp_glDebugMessageInsertAMD glDebugMessageInsertAMD;
	fp_glDrawElementsInstancedARB glDrawElementsInstancedARB;
	fp_glGetSubroutineIndex glGetSubroutineIndex;
	fp_glSamplePatternSGIS glSamplePatternSGIS;
	fp_glVertex3hNV glVertex3hNV;
	fp_glRasterPos3xvOES glRasterPos3xvOES;
	fp_glCompressedTextureImage1DEXT glCompressedTextureImage1DEXT;
	fp_glGetUniformi64vNV glGetUniformi64vNV;
	fp_glMaterialxvOES glMaterialxvOES;
	fp_glNamedProgramLocalParameter4fEXT glNamedProgramLocalParameter4fEXT;
	fp_glVertexAttribL1dEXT glVertexAttribL1dEXT;
	fp_glGetnUniformdvARB glGetnUniformdvARB;
	fp_glSecondaryColor3bEXT glSecondaryColor3bEXT;
	fp_glBeginPerfQueryINTEL glBeginPerfQueryINTEL;
	fp_glProgramUniform1uivEXT glProgramUniform1uivEXT;
	fp_glVertexArrayVertexAttribLFormatEXT glVertexArrayVertexAttribLFormatEXT;
	fp_glCopyTextureSubImage3DEXT glCopyTextureSubImage3DEXT;
	fp_glBindProgramPipeline glBindProgramPipeline;
	fp_glWindowPos4fvMESA glWindowPos4fvMESA;
	fp_glVertexAttribIPointerEXT glVertexAttribIPointerEXT;
	fp_glProgramBufferParametersfvNV glProgramBufferParametersfvNV;
	fp_glAlphaFuncxOES glAlphaFuncxOES;
	fp_glMultiDrawArraysIndirectAMD glMultiDrawArraysIndirectAMD;
	fp_glTextureImage3DMultisampleNV glTextureImage3DMultisampleNV;
	fp_glProgramUniform4uivEXT glProgramUniform4uivEXT;
	fp_glReplacementCodeusvSUN glReplacementCodeusvSUN;
	fp_glPollInstrumentsSGIX glPollInstrumentsSGIX;
	fp_glGetTextureLevelParameteriv glGetTextureLevelParameteriv;
	fp_glGetTexParameterxvOES glGetTexParameterxvOES;
	fp_glMapControlPointsNV glMapControlPointsNV;
	fp_glInvalidateBufferSubData glInvalidateBufferSubData;
	fp_glMultiTexCoord1hNV glMultiTexCoord1hNV;
	fp_glUniformMatrix2fvARB glUniformMatrix2fvARB;
	fp_glUniformHandleui64vNV glUniformHandleui64vNV;
	fp_glGetNamedProgramivEXT glGetNamedProgramivEXT;
	fp_glGetMultiTexGenfvEXT glGetMultiTexGenfvEXT;
	fp_glGetMinmaxEXT glGetMinmaxEXT;
	fp_glMatrixFrustumEXT glMatrixFrustumEXT;
	fp_glDispatchComputeIndirect glDispatchComputeIndirect;
	fp_glInvalidateNamedFramebufferSubData glInvalidateNamedFramebufferSubData;
	fp_glProgramEnvParameter4dARB glProgramEnvParameter4dARB;
	fp_glVertexAttribL3dv glVertexAttribL3dv;
	fp_glGetUniformdv glGetUniformdv;
	fp_glGetMultiTexLevelParameterfvEXT glGetMultiTexLevelParameterfvEXT;
	fp_glFinalCombinerInputNV glFinalCombinerInputNV;
	fp_glCullParameterdvEXT glCullParameterdvEXT;
	fp_glMapVertexAttrib1fAPPLE glMapVertexAttrib1fAPPLE;
	fp_glTangent3fvEXT glTangent3fvEXT;
	fp_glProgramUniform3fvEXT glProgramUniform3fvEXT;
	fp_glMultiTexCoord1iARB glMultiTexCoord1iARB;
	fp_glGetVertexArrayPointervEXT glGetVertexArrayPointervEXT;
	fp_glGlobalAlphaFactorubSUN glGlobalAlphaFactorubSUN;
	fp_glVertexAttribL1ui64NV glVertexAttribL1ui64NV;
	fp_glPointParameterfSGIS glPointParameterfSGIS;
	fp_glGetNamedProgramLocalParameterIuivEXT glGetNamedProgramLocalParameterIuivEXT;
	fp_glColorSubTableEXT glColorSubTableEXT;
	fp_glPixelTexGenParameterfvSGIS glPixelTexGenParameterfvSGIS;
	fp_glQueryObjectParameteruiAMD glQueryObjectParameteruiAMD;
	fp_glVertexAttribs1fvNV glVertexAttribs1fvNV;
	fp_glVertexAttrib4NusvARB glVertexAttrib4NusvARB;
	fp_glVariantPointerEXT glVariantPointerEXT;
	fp_glTextureBuffer glTextureBuffer;
	fp_glBlendFunciARB glBlendFunciARB;
	fp_glProgramEnvParametersI4ivNV glProgramEnvParametersI4ivNV;
	fp_glPathGlyphIndexArrayNV glPathGlyphIndexArrayNV;
	fp_glCopyImageSubData glCopyImageSubData;
	fp_glGetUniformSubroutineuiv glGetUniformSubroutineuiv;
	fp_glBindVertexBuffer glBindVertexBuffer;
	fp_glTexCoord2bOES glTexCoord2bOES;
	fp_glDebugMessageInsert glDebugMessageInsert;
	fp_glGetPerfMonitorCounterDataAMD glGetPerfMonitorCounterDataAMD;
	fp_glIsVariantEnabledEXT glIsVariantEnabledEXT;
	fp_glBindMaterialParameterEXT glBindMaterialParameterEXT;
	fp_glConservativeRasterParameterfNV glConservativeRasterParameterfNV;
	fp_glMultiTexGenivEXT glMultiTexGenivEXT;
	fp_glNamedFramebufferTexture2DEXT glNamedFramebufferTexture2DEXT;
	fp_glDrawElementArrayAPPLE glDrawElementArrayAPPLE;
	fp_glFragmentLightivSGIX glFragmentLightivSGIX;
	fp_glBindImageTexture glBindImageTexture;
	fp_glMultiTexCoordPointerEXT glMultiTexCoordPointerEXT;
	fp_glSyncTextureINTEL glSyncTextureINTEL;
	fp_glCreateSamplers glCreateSamplers;
	fp_glCombinerParameterfNV glCombinerParameterfNV;
	fp_glGetArrayObjectivATI glGetArrayObjectivATI;
	fp_glVertexStream3fvATI glVertexStream3fvATI;
	fp_glSampleMapATI glSampleMapATI;
	fp_glVertexAttrib4bvARB glVertexAttrib4bvARB;
	fp_glBinormal3ivEXT glBinormal3ivEXT;
	fp_glMultiDrawArraysIndirectCountARB glMultiDrawArraysIndirectCountARB;
	fp_glUniformBufferEXT glUniformBufferEXT;
	fp_glWindowPos2ivMESA glWindowPos2ivMESA;
	fp_glVertexAttribL1d glVertexAttribL1d;
	fp_glMultiTexSubImage1DEXT glMultiTexSubImage1DEXT;
	fp_glProgramUniformMatrix2x3fvEXT glProgramUniformMatrix2x3fvEXT;
	fp_glBufferDataARB glBufferDataARB;
	fp_glVertexAttribIFormat glVertexAttribIFormat;
	fp_glCreateFramebuffers glCreateFramebuffers;
	fp_glNormalStream3dvATI glNormalStream3dvATI;
	fp_glUniform3i64vNV glUniform3i64vNV;
	fp_glPathTexGenNV glPathTexGenNV;
	fp_glUniform2uivEXT glUniform2uivEXT;
	fp_glMultiDrawElementsIndirect glMultiDrawElementsIndirect;
	fp_glStencilThenCoverStrokePathInstancedNV glStencilThenCoverStrokePathInstancedNV;
	fp_glGetProgramPipelineInfoLogEXT glGetProgramPipelineInfoLogEXT;
	fp_glMakeImageHandleResidentNV glMakeImageHandleResidentNV;
	fp_glGetMultiTexParameterfvEXT glGetMultiTexParameterfvEXT;
	fp_glDepthRangeIndexed glDepthRangeIndexed;
	fp_glColorMaskIndexedEXT glColorMaskIndexedEXT;
	fp_glMatrixScalefEXT glMatrixScalefEXT;
	fp_glBindTextureUnitParameterEXT glBindTextureUnitParameterEXT;
	fp_glDrawCommandsStatesNV glDrawCommandsStatesNV;
	fp_glReplacementCodeuiNormal3fVertex3fvSUN glReplacementCodeuiNormal3fVertex3fvSUN;
	fp_glDeletePerfQueryINTEL glDeletePerfQueryINTEL;
	fp_glGetUniformivARB glGetUniformivARB;
	fp_glGetActiveUniformARB glGetActiveUniformARB;
	fp_glVertexAttribI3ivEXT glVertexAttribI3ivEXT;
	fp_glNamedCopyBufferSubDataEXT glNamedCopyBufferSubDataEXT;
	fp_glVertexAttribI1ivEXT glVertexAttribI1ivEXT;
	fp_glBufferSubDataARB glBufferSubDataARB;
	fp_glVertexStream4dATI glVertexStream4dATI;
	fp_glPixelStorex glPixelStorex;
	fp_glGetnUniformui64vARB glGetnUniformui64vARB;
	fp_glVertexAttribI1uiEXT glVertexAttribI1uiEXT;
	fp_glProgramUniform3i64vARB glProgramUniform3i64vARB;
	fp_glProgramUniform4ui glProgramUniform4ui;
	fp_glResetHistogramEXT glResetHistogramEXT;
	fp_glLightxOES glLightxOES;
	fp_glNamedBufferData glNamedBufferData;
	fp_glVertexStream3sATI glVertexStream3sATI;
	fp_glVertexAttrib3fvARB glVertexAttrib3fvARB;
	fp_glClearNamedBufferSubData glClearNamedBufferSubData;
	fp_glProgramUniformHandleui64ARB glProgramUniformHandleui64ARB;
	fp_glUniform3iARB glUniform3iARB;
	fp_glCreateProgramObjectARB glCreateProgramObjectARB;
	fp_glMultiTexCoord1dvARB glMultiTexCoord1dvARB;
	fp_glProgramUniform3dvEXT glProgramUniform3dvEXT;
	fp_glListDrawCommandsStatesClientNV glListDrawCommandsStatesClientNV;
	fp_glMultiTexImage2DEXT glMultiTexImage2DEXT;
	fp_glProgramUniform1i64NV glProgramUniform1i64NV;
	fp_glGetObjectBufferivATI glGetObjectBufferivATI;
	fp_glMultiTexCoord1fvARB glMultiTexCoord1fvARB;
	fp_glReplacementCodeuiColor4ubVertex3fvSUN glReplacementCodeuiColor4ubVertex3fvSUN;
	fp_glBlendFuncSeparateINGR glBlendFuncSeparateINGR;
	fp_glUniform1ui64ARB glUniform1ui64ARB;
	fp_glGetVideoCaptureStreamfvNV glGetVideoCaptureStreamfvNV;
	fp_glVertexAttrib2fARB glVertexAttrib2fARB;
	fp_glGetCompressedTextureSubImage glGetCompressedTextureSubImage;
	fp_glCopyImageSubDataNV glCopyImageSubDataNV;
	fp_glVertexStream1iATI glVertexStream1iATI;
	fp_glPatchParameterfv glPatchParameterfv;
	fp_glIsFramebufferEXT glIsFramebufferEXT;
	fp_glTextureStorage2D glTextureStorage2D;
	fp_glProgramUniform1ui64ARB glProgramUniform1ui64ARB;
	fp_glTexBufferRange glTexBufferRange;
	fp_glGetPixelTexGenParameterivSGIS glGetPixelTexGenParameterivSGIS;
	fp_glTextureSubImage3DEXT glTextureSubImage3DEXT;
	fp_glProgramUniform1uiEXT glProgramUniform1uiEXT;
	fp_glUniform2i64NV glUniform2i64NV;
	fp_glVertexAttrib3sNV glVertexAttrib3sNV;
	fp_glClearColorxOES glClearColorxOES;
	fp_glVertexAttrib4NivARB glVertexAttrib4NivARB;
	fp_glGlobalAlphaFactorfSUN glGlobalAlphaFactorfSUN;
	fp_glBlendEquationSeparateIndexedAMD glBlendEquationSeparateIndexedAMD;
	fp_glGetPerfCounterInfoINTEL glGetPerfCounterInfoINTEL;
	fp_glProgramLocalParameterI4uiNV glProgramLocalParameterI4uiNV;
	fp_glPixelZoomxOES glPixelZoomxOES;
	fp_glGetCombinerOutputParameterivNV glGetCombinerOutputParameterivNV;
	fp_glRasterPos2xvOES glRasterPos2xvOES;
	fp_glProgramUniform2i64vARB glProgramUniform2i64vARB;
	fp_glVertexArrayVertexBuffers glVertexArrayVertexBuffers;
	fp_glUniform1ui64NV glUniform1ui64NV;
	fp_glProgramParameteri glProgramParameteri;
	fp_glPassThroughxOES glPassThroughxOES;
	fp_glNormal3xOES glNormal3xOES;
	fp_glVertexStream2dvATI glVertexStream2dvATI;
	fp_glPathStencilDepthOffsetNV glPathStencilDepthOffsetNV;
	fp_glIsStateNV glIsStateNV;
	fp_glDebugMessageCallbackKHR glDebugMessageCallbackKHR;
	fp_glVertexAttribL2dEXT glVertexAttribL2dEXT;
	fp_glGetImageTransformParameterfvHP glGetImageTransformParameterfvHP;
	fp_glVertex3xOES glVertex3xOES;
	fp_glFogFuncSGIS glFogFuncSGIS;
	fp_glWeightPointerARB glWeightPointerARB;
	fp_glFinishFenceNV glFinishFenceNV;
	fp_glProgramUniformMatrix3x2dvEXT glProgramUniformMatrix3x2dvEXT;
	fp_glEnableVertexArrayAttribEXT glEnableVertexArrayAttribEXT;
	fp_glProgramUniform2uivEXT glProgramUniform2uivEXT;
	fp_glPixelMapx glPixelMapx;
	fp_glVertexAttrib3fvNV glVertexAttrib3fvNV;
	fp_glWindowPos2fMESA glWindowPos2fMESA;
	fp_glCopyConvolutionFilter1DEXT glCopyConvolutionFilter1DEXT;
	fp_glBindFramebufferEXT glBindFramebufferEXT;
	fp_glGetColorTableParameterfvEXT glGetColorTableParameterfvEXT;
	fp_glVertexAttrib4ubvARB glVertexAttrib4ubvARB;
	fp_glDrawTextureNV glDrawTextureNV;
	fp_glVertexStream2dATI glVertexStream2dATI;
	fp_glGetCombinerInputParameterfvNV glGetCombinerInputParameterfvNV;
	fp_glPointParameterfARB glPointParameterfARB;
	fp_glUniform1fvARB glUniform1fvARB;
	fp_glGetVariantFloatvEXT glGetVariantFloatvEXT;
	fp_glVertexAttribL2ui64NV glVertexAttribL2ui64NV;
	fp_glWindowPos2dMESA glWindowPos2dMESA;
	fp_glGetTexGenxvOES glGetTexGenxvOES;
	fp_glCompressedTexSubImage1DARB glCompressedTexSubImage1DARB;
	fp_glVertexStream2svATI glVertexStream2svATI;
	fp_glBindTextureUnit glBindTextureUnit;
	fp_glProgramEnvParameterI4uiNV glProgramEnvParameterI4uiNV;
	fp_glGetProgramPipelineInfoLog glGetProgramPipelineInfoLog;
	fp_glProgramUniform4i64vARB glProgramUniform4i64vARB;
	fp_glGetUniformfvARB glGetUniformfvARB;
	fp_glVertexAttrib2hvNV glVertexAttrib2hvNV;
	fp_glTextureParameterivEXT glTextureParameterivEXT;
	fp_glUniform3d glUniform3d;
	fp_glActiveProgramEXT glActiveProgramEXT;
	fp_glVertexAttribs4dvNV glVertexAttribs4dvNV;
	fp_glUniform3ui64vARB glUniform3ui64vARB;
	fp_glProgramUniform1ui64vARB glProgramUniform1ui64vARB;
	fp_glTextureParameterfEXT glTextureParameterfEXT;
	fp_glValidateProgramPipelineEXT glValidateProgramPipelineEXT;
	fp_glSetFragmentShaderConstantATI glSetFragmentShaderConstantATI;
	fp_glColorSubTable glColorSubTable;
	fp_glReplacementCodeuiSUN glReplacementCodeuiSUN;
	fp_glVertexAttrib4sARB glVertexAttrib4sARB;
	fp_glWeightusvARB glWeightusvARB;
	fp_glMultiTexCoord2xOES glMultiTexCoord2xOES;
	fp_glTexCoord2fVertex3fSUN glTexCoord2fVertex3fSUN;
	fp_glPolygonOffsetEXT glPolygonOffsetEXT;
	fp_glWeightPathsNV glWeightPathsNV;
	fp_glCombinerStageParameterfvNV glCombinerStageParameterfvNV;
	fp_glPointParameterfEXT glPointParameterfEXT;
	fp_glCopyTexImage1DEXT glCopyTexImage1DEXT;
	fp_glMatrixMultfEXT glMatrixMultfEXT;
	fp_glCompressedTextureSubImage3DEXT glCompressedTextureSubImage3DEXT;
	fp_glGetTexLevelParameterxvOES glGetTexLevelParameterxvOES;
	fp_glVertexAttribL3dvEXT glVertexAttribL3dvEXT;
	fp_glGetPerfMonitorCounterStringAMD glGetPerfMonitorCounterStringAMD;
	fp_glGetTextureLevelParameterivEXT glGetTextureLevelParameterivEXT;
	fp_glAlphaFragmentOp2ATI glAlphaFragmentOp2ATI;
	fp_glGetnTexImageARB glGetnTexImageARB;
	fp_glVertexArrayParameteriAPPLE glVertexArrayParameteriAPPLE;
	fp_glBlendFuncSeparateiARB glBlendFuncSeparateiARB;
	fp_glWindowPos2iARB glWindowPos2iARB;
	fp_glFragmentLightModelivSGIX glFragmentLightModelivSGIX;
	fp_glSecondaryColor3hNV glSecondaryColor3hNV;
	fp_glProgramUniform3iEXT glProgramUniform3iEXT;
	fp_glTexCoord4hNV glTexCoord4hNV;
	fp_glDrawElementsIndirect glDrawElementsIndirect;
	fp_glDeletePerfMonitorsAMD glDeletePerfMonitorsAMD;
	fp_glIsRenderbufferEXT glIsRenderbufferEXT;
	fp_glDrawCommandsNV glDrawCommandsNV;
	fp_glUniform3ivARB glUniform3ivARB;
	fp_glGetInvariantFloatvEXT glGetInvariantFloatvEXT;
	fp_glMatrixMultTransposedEXT glMatrixMultTransposedEXT;
	fp_glRequestResidentProgramsNV glRequestResidentProgramsNV;
	fp_glMatrixMult3x3fNV glMatrixMult3x3fNV;
	fp_glUniform4iARB glUniform4iARB;
	fp_glPathSubCommandsNV glPathSubCommandsNV;
	fp_glGetFinalCombinerInputParameterivNV glGetFinalCombinerInputParameterivNV;
	fp_glFrustumfOES glFrustumfOES;
	fp_glBindVertexBuffers glBindVertexBuffers;
	fp_glMultiTexCoord2svARB glMultiTexCoord2svARB;
	fp_glWindowPos3ivARB glWindowPos3ivARB;
	fp_glTexCoordFormatNV glTexCoordFormatNV;
	fp_glBlitNamedFramebuffer glBlitNamedFramebuffer;
	fp_glMatrixLoadTransposefEXT glMatrixLoadTransposefEXT;
	fp_glMultiTexGenfEXT glMultiTexGenfEXT;
	fp_glShaderStorageBlockBinding glShaderStorageBlockBinding;
	fp_glReplacementCodeuiColor4fNormal3fVertex3fSUN glReplacementCodeuiColor4fNormal3fVertex3fSUN;
	fp_glCheckNamedFramebufferStatusEXT glCheckNamedFramebufferStatusEXT;
	fp_glVertexArrayVertexAttribFormatEXT glVertexArrayVertexAttribFormatEXT;
	fp_glVertex2hNV glVertex2hNV;
	fp_glDeleteVertexShaderEXT glDeleteVertexShaderEXT;
	fp_glTexImage3DEXT glTexImage3DEXT;
	fp_glProgramLocalParameterI4ivNV glProgramLocalParameterI4ivNV;
	fp_glGlobalAlphaFactoriSUN glGlobalAlphaFactoriSUN;
	fp_glTextureStorage1D glTextureStorage1D;
	fp_glPathCommandsNV glPathCommandsNV;
	fp_glBinormal3sEXT glBinormal3sEXT;
	fp_glGetProgramInterfaceiv glGetProgramInterfaceiv;
	fp_glMatrixIndexPointerARB glMatrixIndexPointerARB;
	fp_glTexCoordPointerEXT glTexCoordPointerEXT;
	fp_glMultiTexGeniEXT glMultiTexGeniEXT;
	fp_glVertexAttrib2fNV glVertexAttrib2fNV;
	fp_glNamedProgramStringEXT glNamedProgramStringEXT;
	fp_glMapNamedBuffer glMapNamedBuffer;
	fp_glGetMinmaxParameteriv glGetMinmaxParameteriv;
	fp_glGetTextureSubImage glGetTextureSubImage;
	fp_glBinormal3fEXT glBinormal3fEXT;
	fp_glNormalStream3iATI glNormalStream3iATI;
	fp_glProgramBufferParametersIivNV glProgramBufferParametersIivNV;
	fp_glMapGrid1xOES glMapGrid1xOES;
	fp_glBindBuffersBase glBindBuffersBase;
	fp_glFlushMappedNamedBufferRangeEXT glFlushMappedNamedBufferRangeEXT;
	fp_glUniformui64NV glUniformui64NV;
	fp_glVertexAttrib2fvNV glVertexAttrib2fvNV;
	fp_glProgramParameters4fvNV glProgramParameters4fvNV;
	fp_glPatchParameteri glPatchParameteri;
	fp_glGetTexFilterFuncSGIS glGetTexFilterFuncSGIS;
	fp_glVertexArrayVertexBindingDivisorEXT glVertexArrayVertexBindingDivisorEXT;
	fp_glMultiTexCoord3svARB glMultiTexCoord3svARB;
	fp_glBindProgramNV glBindProgramNV;
	fp_glGetConvolutionParameteriv glGetConvolutionParameteriv;
	fp_glGetProgramLocalParameterfvARB glGetProgramLocalParameterfvARB;
	fp_glGenFragmentShadersATI glGenFragmentShadersATI;
	fp_glTexBumpParameterivATI glTexBumpParameterivATI;
	fp_glGetNamedFramebufferAttachmentParameteriv glGetNamedFramebufferAttachmentParameteriv;
	fp_glGenVertexArraysAPPLE glGenVertexArraysAPPLE;
	fp_glNormal3xvOES glNormal3xvOES;
	fp_glPassTexCoordATI glPassTexCoordATI;
	fp_glFramebufferTextureFaceARB glFramebufferTextureFaceARB;
	fp_glTextureStorage2DEXT glTextureStorage2DEXT;
	fp_glVertexArrayFogCoordOffsetEXT glVertexArrayFogCoordOffsetEXT;
	fp_glTexEnvxvOES glTexEnvxvOES;
	fp_glDeleteNamedStringARB glDeleteNamedStringARB;
	fp_glGenOcclusionQueriesNV glGenOcclusionQueriesNV;
	fp_glClientAttribDefaultEXT glClientAttribDefaultEXT;
	fp_glProgramUniform2i64ARB glProgramUniform2i64ARB;
	fp_glVertexAttribIFormatNV glVertexAttribIFormatNV;
	fp_glVertexAttribL1ui64vNV glVertexAttribL1ui64vNV;
	fp_glGetVertexAttribfvARB glGetVertexAttribfvARB;
	fp_glGetGraphicsResetStatusKHR glGetGraphicsResetStatusKHR;
	fp_glVertexAttrib2dNV glVertexAttrib2dNV;
	fp_glProgramUniform2iEXT glProgramUniform2iEXT;
	fp_glClientActiveVertexStreamATI glClientActiveVertexStreamATI;
	fp_glRasterPos3xOES glRasterPos3xOES;
	fp_glClearDepthxOES glClearDepthxOES;
	fp_glTexCoord2fNormal3fVertex3fvSUN glTexCoord2fNormal3fVertex3fvSUN;
	fp_glUnmapNamedBufferEXT glUnmapNamedBufferEXT;
	fp_glGetTransformFeedbacki_v glGetTransformFeedbacki_v;
	fp_glUniform4fvARB glUniform4fvARB;
	fp_glRenderbufferStorageMultisampleCoverageNV glRenderbufferStorageMultisampleCoverageNV;
	fp_glGetFloati_vEXT glGetFloati_vEXT;
	fp_glBindAttribLocationARB glBindAttribLocationARB;
	fp_glBufferAddressRangeNV glBufferAddressRangeNV;
	fp_glGenProgramsARB glGenProgramsARB;
	fp_glMultiTexEnvivEXT glMultiTexEnvivEXT;
	fp_glSecondaryColor3uiEXT glSecondaryColor3uiEXT;
	fp_glCompressedTextureImage2DEXT glCompressedTextureImage2DEXT;
	fp_glCopyTexImage2DEXT glCopyTexImage2DEXT;
	fp_glUniform2d glUniform2d;
	fp_glFramebufferTextureFaceEXT glFramebufferTextureFaceEXT;
	fp_glMultiTexCoord4bvOES glMultiTexCoord4bvOES;
	fp_glGetVertexArrayPointeri_vEXT glGetVertexArrayPointeri_vEXT;
	fp_glNamedProgramLocalParameter4dEXT glNamedProgramLocalParameter4dEXT;
	fp_glBinormal3bEXT glBinormal3bEXT;
	fp_glProgramUniform2fv glProgramUniform2fv;
	fp_glColor3fVertex3fSUN glColor3fVertex3fSUN;
	fp_glNormal3fVertex3fvSUN glNormal3fVertex3fvSUN;
	fp_glCopyMultiTexSubImage3DEXT glCopyMultiTexSubImage3DEXT;
	fp_glProgramLocalParameterI4iNV glProgramLocalParameterI4iNV;
	fp_glProgramUniformMatrix2x4dv glProgramUniformMatrix2x4dv;
	fp_glPathMemoryGlyphIndexArrayNV glPathMemoryGlyphIndexArrayNV;
	fp_glDrawArraysEXT glDrawArraysEXT;
	fp_glBlendEquationEXT glBlendEquationEXT;
	fp_glCopyTextureSubImage2DEXT glCopyTextureSubImage2DEXT;
	fp_glVertexAttrib2dvNV glVertexAttrib2dvNV;
	fp_glGenPerfMonitorsAMD glGenPerfMonitorsAMD;
	fp_glGetHistogramParameterfv glGetHistogramParameterfv;
	fp_glVertexFormatNV glVertexFormatNV;
	fp_glBlendFuncIndexedAMD glBlendFuncIndexedAMD;
	fp_glVertexAttribL2ui64vNV glVertexAttribL2ui64vNV;
	fp_glVertexAttribL4i64NV glVertexAttribL4i64NV;
	fp_glMatrixTranslatedEXT glMatrixTranslatedEXT;
	fp_glMakeTextureHandleResidentARB glMakeTextureHandleResidentARB;
	fp_glBinormal3dvEXT glBinormal3dvEXT;
	fp_glImportSyncEXT glImportSyncEXT;
	fp_glGetListParameterfvSGIX glGetListParameterfvSGIX;
	fp_glPNTrianglesiATI glPNTrianglesiATI;
	fp_glBindVertexArrayAPPLE glBindVertexArrayAPPLE;
	fp_glObjectPtrLabel glObjectPtrLabel;
	fp_glGetDebugMessageLog glGetDebugMessageLog;
	fp_glTrackMatrixNV glTrackMatrixNV;
	fp_glProgramPathFragmentInputGenNV glProgramPathFragmentInputGenNV;
	fp_glTangent3ivEXT glTangent3ivEXT;
	fp_glMakeTextureHandleNonResidentNV glMakeTextureHandleNonResidentNV;
	fp_glVertexAttribs4ubvNV glVertexAttribs4ubvNV;
	fp_glBindBufferBaseNV glBindBufferBaseNV;
	fp_glFogCoordhvNV glFogCoordhvNV;
	fp_glGetnPolygonStippleARB glGetnPolygonStippleARB;
	fp_glUniform2i64vNV glUniform2i64vNV;
	fp_glMultiTexSubImage2DEXT glMultiTexSubImage2DEXT;
	fp_glReplacementCodeuiColor3fVertex3fSUN glReplacementCodeuiColor3fVertex3fSUN;
	fp_glTangent3dvEXT glTangent3dvEXT;
	fp_glVertexWeighthvNV glVertexWeighthvNV;
	fp_glFramebufferTextureLayerARB glFramebufferTextureLayerARB;
	fp_glMultiTexCoord1xvOES glMultiTexCoord1xvOES;
	fp_glTransformPathNV glTransformPathNV;
	fp_glProgramNamedParameter4dNV glProgramNamedParameter4dNV;
	fp_glProgramUniform1dEXT glProgramUniform1dEXT;
	fp_glNormal3hvNV glNormal3hvNV;
	fp_glGetPointervKHR glGetPointervKHR;
	fp_glGetCombinerOutputParameterfvNV glGetCombinerOutputParameterfvNV;
	fp_glPushDebugGroup glPushDebugGroup;
	fp_glCreateShaderObjectARB glCreateShaderObjectARB;
	fp_glGetStageIndexNV glGetStageIndexNV;
	fp_glGetColorTableParameterfv glGetColorTableParameterfv;
	fp_glGetNamedBufferPointervEXT glGetNamedBufferPointervEXT;
	fp_glTextureBarrierNV glTextureBarrierNV;
	fp_glPopDebugGroupKHR glPopDebugGroupKHR;
	fp_glColor4ubVertex3fvSUN glColor4ubVertex3fvSUN;
	fp_glGetCommandHeaderNV glGetCommandHeaderNV;
	fp_glGetPerfMonitorCounterInfoAMD glGetPerfMonitorCounterInfoAMD;
	fp_glVertexAttrib1svARB glVertexAttrib1svARB;
	fp_glNormalStream3ivATI glNormalStream3ivATI;
	fp_glMatrixMultTransposefEXT glMatrixMultTransposefEXT;
	fp_glDetailTexFuncSGIS glDetailTexFuncSGIS;
	fp_glIndexPointerListIBM glIndexPointerListIBM;
	fp_glVertexAttribI4iEXT glVertexAttribI4iEXT;
	fp_glBeginTransformFeedbackNV glBeginTransformFeedbackNV;
	fp_glColorFragmentOp3ATI glColorFragmentOp3ATI;
	fp_glResizeBuffersMESA glResizeBuffersMESA;
	fp_glGetMinmaxParameterfv glGetMinmaxParameterfv;
	fp_glClientActiveTextureARB glClientActiveTextureARB;
	fp_glProgramUniform1dvEXT glProgramUniform1dvEXT;
	fp_glNamedBufferSubData glNamedBufferSubData;
	fp_glGetMultiTexParameterIivEXT glGetMultiTexParameterIivEXT;
	fp_glObjectUnpurgeableAPPLE glObjectUnpurgeableAPPLE;
	fp_glVertexAttribs2dvNV glVertexAttribs2dvNV;
	fp_glReplacementCodeuiTexCoord2fVertex3fSUN glReplacementCodeuiTexCoord2fVertex3fSUN;
	fp_glGetMapParameterfvNV glGetMapParameterfvNV;
	fp_glProgramUniform4ivEXT glProgramUniform4ivEXT;
	fp_glProgramUniform3ui64vNV glProgramUniform3ui64vNV;
	fp_glTexFilterFuncSGIS glTexFilterFuncSGIS;
	fp_glSpriteParameterfvSGIX glSpriteParameterfvSGIX;
	fp_glCopyMultiTexImage1DEXT glCopyMultiTexImage1DEXT;
	fp_glGetVertexAttribIuivEXT glGetVertexAttribIuivEXT;
	fp_glUniformMatrix2x4dv glUniformMatrix2x4dv;
	fp_glGetProgramResourceLocationIndex glGetProgramResourceLocationIndex;
	fp_glColor3hNV glColor3hNV;
	fp_glProgramNamedParameter4fNV glProgramNamedParameter4fNV;
	fp_glGetInvariantBooleanvEXT glGetInvariantBooleanvEXT;
	fp_glTexStorage2DMultisample glTexStorage2DMultisample;
	fp_glGetObjectLabel glGetObjectLabel;
	fp_glVertexAttribL1dvEXT glVertexAttribL1dvEXT;
	fp_glGetActiveSubroutineUniformiv glGetActiveSubroutineUniformiv;
	fp_glCompressedTexSubImage2DARB glCompressedTexSubImage2DARB;
	fp_glIsProgramPipelineEXT glIsProgramPipelineEXT;
	fp_glVertex2hvNV glVertex2hvNV;
	fp_glActiveShaderProgram glActiveShaderProgram;
	fp_glWindowPos3dARB glWindowPos3dARB;
	fp_glClipControl glClipControl;
	fp_glVertexAttribs2fvNV glVertexAttribs2fvNV;
	fp_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN;
	fp_glTexCoord1bOES glTexCoord1bOES;
	fp_glNormalStream3bvATI glNormalStream3bvATI;
	fp_glWindowPos2dARB glWindowPos2dARB;
	fp_glGetProgramParameterdvNV glGetProgramParameterdvNV;
	fp_glMap1xOES glMap1xOES;
	fp_glTexCoord4fVertex4fvSUN glTexCoord4fVertex4fvSUN;
	fp_glActiveVaryingNV glActiveVaryingNV;
	fp_glGetMultiTexGendvEXT glGetMultiTexGendvEXT;
	fp_glClearNamedBufferSubDataEXT glClearNamedBufferSubDataEXT;
	fp_glGetTextureSamplerHandleARB glGetTextureSamplerHandleARB;
	fp_glGetActiveAttribARB glGetActiveAttribARB;
	fp_glHistogramEXT glHistogramEXT;
	fp_glPixelTransformParameteriEXT glPixelTransformParameteriEXT;
	fp_glFinishTextureSUNX glFinishTextureSUNX;
	fp_glUniformMatrix3x4dv glUniformMatrix3x4dv;
	fp_glVertexAttrib4fARB glVertexAttrib4fARB;
	fp_glGetPathColorGenivNV glGetPathColorGenivNV;
	fp_glGetProgramResourceLocation glGetProgramResourceLocation;
	fp_glVertexArrayAttribLFormat glVertexArrayAttribLFormat;
	fp_glVertexArrayVertexAttribOffsetEXT glVertexArrayVertexAttribOffsetEXT;
	fp_glIndexFormatNV glIndexFormatNV;
	fp_glReplacementCodeuiVertex3fvSUN glReplacementCodeuiVertex3fvSUN;
	fp_glViewportIndexedfv glViewportIndexedfv;
	fp_glGetVertexAttribPointervARB glGetVertexAttribPointervARB;
	fp_glScissorIndexed glScissorIndexed;
	fp_glMatrixIndexuivARB glMatrixIndexuivARB;
	fp_glVertexAttrib1hNV glVertexAttrib1hNV;
	fp_glWindowPos3svMESA glWindowPos3svMESA;
	fp_glStencilOpSeparateATI glStencilOpSeparateATI;
	fp_glBlendEquationSeparateiARB glBlendEquationSeparateiARB;
	fp_glVertexAttrib1fNV glVertexAttrib1fNV;
	fp_glMapVertexAttrib2fAPPLE glMapVertexAttrib2fAPPLE;
	fp_glClearBufferSubData glClearBufferSubData;
	fp_glTexStorage1D glTexStorage1D;
	fp_glVertexAttribI3iEXT glVertexAttribI3iEXT;
	fp_glMakeTextureHandleNonResidentARB glMakeTextureHandleNonResidentARB;
	fp_glGetnColorTableARB glGetnColorTableARB;
	fp_glProgramUniformMatrix2dvEXT glProgramUniformMatrix2dvEXT;
	fp_glVertexAttribs2hvNV glVertexAttribs2hvNV;
	fp_glProgramUniformui64vNV glProgramUniformui64vNV;
	fp_glClipPlanefOES glClipPlanefOES;
	fp_glDisableVertexArrayAttribEXT glDisableVertexArrayAttribEXT;
	fp_glValidateProgramARB glValidateProgramARB;
	fp_glVertexAttribPointerARB glVertexAttribPointerARB;
	fp_glDeleteFramebuffersEXT glDeleteFramebuffersEXT;
	fp_glDeleteProgramPipelinesEXT glDeleteProgramPipelinesEXT;
	fp_glVertexAttrib1fvNV glVertexAttrib1fvNV;
	fp_glIsQueryARB glIsQueryARB;
	fp_glEnableVariantClientStateEXT glEnableVariantClientStateEXT;
	fp_glTexBumpParameterfvATI glTexBumpParameterfvATI;
	fp_glGetInvariantIntegervEXT glGetInvariantIntegervEXT;
	fp_glConvolutionParameterxvOES glConvolutionParameterxvOES;
	fp_glGenFramebuffersEXT glGenFramebuffersEXT;
	fp_glVertexArrayColorOffsetEXT glVertexArrayColorOffsetEXT;
	fp_glMultiTexCoord3ivARB glMultiTexCoord3ivARB;
	fp_glVertexWeightfEXT glVertexWeightfEXT;
	fp_glIsTextureHandleResidentARB glIsTextureHandleResidentARB;
	fp_glWindowPos4ivMESA glWindowPos4ivMESA;
	fp_glDrawElementsInstancedBaseVertexBaseInstance glDrawElementsInstancedBaseVertexBaseInstance;
	fp_glMapNamedBufferRangeEXT glMapNamedBufferRangeEXT;
	fp_glCreateShaderProgramv glCreateShaderProgramv;
	fp_glPNTrianglesfATI glPNTrianglesfATI;
	fp_glGlobalAlphaFactorusSUN glGlobalAlphaFactorusSUN;
	fp_glVertexAttrib3dvNV glVertexAttrib3dvNV;
	fp_glMultiTexCoord3sARB glMultiTexCoord3sARB;
	fp_glGetnConvolutionFilterARB glGetnConvolutionFilterARB;
	fp_glCompressedTextureSubImage2D glCompressedTextureSubImage2D;
	fp_glNamedRenderbufferStorageMultisampleEXT glNamedRenderbufferStorageMultisampleEXT;
	fp_glPolygonOffsetClampEXT glPolygonOffsetClampEXT;
	fp_glTextureRangeAPPLE glTextureRangeAPPLE;
	fp_glBlendEquationIndexedAMD glBlendEquationIndexedAMD;
	fp_glVDPAUSurfaceAccessNV glVDPAUSurfaceAccessNV;
	fp_glSampleMaskEXT glSampleMaskEXT;
	fp_glProgramUniform2fvEXT glProgramUniform2fvEXT;
	fp_glTexCoord1xvOES glTexCoord1xvOES;
	fp_glVertexAttrib1sARB glVertexAttrib1sARB;
	fp_glProgramParameter4dvNV glProgramParameter4dvNV;
	fp_glTextureParameterIuivEXT glTextureParameterIuivEXT;
	fp_glGetColorTableParameterfvSGI glGetColorTableParameterfvSGI;
	fp_glDeleteRenderbuffersEXT glDeleteRenderbuffersEXT;
	fp_glVertexAttrib1svNV glVertexAttrib1svNV;
	fp_glNamedFramebufferTextureFaceEXT glNamedFramebufferTextureFaceEXT;
	fp_glProgramUniform2ui64vNV glProgramUniform2ui64vNV;
	fp_glReleaseShaderCompiler glReleaseShaderCompiler;
	fp_glTexCoord3bvOES glTexCoord3bvOES;
	fp_glIsVertexAttribEnabledAPPLE glIsVertexAttribEnabledAPPLE;
	fp_glSetFenceAPPLE glSetFenceAPPLE;
	fp_glStateCaptureNV glStateCaptureNV;
	fp_glWeightsvARB glWeightsvARB;
	fp_glBufferPageCommitmentARB glBufferPageCommitmentARB;
	fp_glGetHistogramParameterivEXT glGetHistogramParameterivEXT;
	fp_glVertexAttribI1iEXT glVertexAttribI1iEXT;
	fp_glClearDepthf glClearDepthf;
	fp_glGetDoublei_vEXT glGetDoublei_vEXT;
	fp_glFogCoordfEXT glFogCoordfEXT;
	fp_glVertexAttrib2dARB glVertexAttrib2dARB;
	fp_glMultiTexCoord4dARB glMultiTexCoord4dARB;
	fp_glReadnPixelsARB glReadnPixelsARB;
	fp_glMultiTexBufferEXT glMultiTexBufferEXT;
	fp_glWindowPos4dvMESA glWindowPos4dvMESA;
	fp_glInvalidateNamedFramebufferData glInvalidateNamedFramebufferData;
	fp_glUseProgramStages glUseProgramStages;
	fp_glColor3xOES glColor3xOES;
	fp_glUniform3i64ARB glUniform3i64ARB;
	fp_glProgramUniform2dEXT glProgramUniform2dEXT;
	fp_glBlendEquationiARB glBlendEquationiARB;
	fp_glGetMapAttribParameterfvNV glGetMapAttribParameterfvNV;
	fp_glGetVertexAttribLdv glGetVertexAttribLdv;
	fp_glGetnUniformuiv glGetnUniformuiv;
	fp_glGetUniformui64vNV glGetUniformui64vNV;
	fp_glNamedRenderbufferStorageEXT glNamedRenderbufferStorageEXT;
	fp_glVertexAttrib3dNV glVertexAttrib3dNV;
	fp_glTextureStorage1DEXT glTextureStorage1DEXT;
	fp_glPixelTexGenParameteriSGIS glPixelTexGenParameteriSGIS;
	fp_glColorTableEXT glColorTableEXT;
	fp_glMultiTexCoord3xvOES glMultiTexCoord3xvOES;
	fp_glExecuteProgramNV glExecuteProgramNV;
	fp_glVariantArrayObjectATI glVariantArrayObjectATI;
	fp_glColor3xvOES glColor3xvOES;
	fp_glGetnUniformuivKHR glGetnUniformuivKHR;
	fp_glDeleteProgramsNV glDeleteProgramsNV;
	fp_glNormalFormatNV glNormalFormatNV;
	fp_glVertexAttrib3fNV glVertexAttrib3fNV;
	fp_glClearNamedFramebufferiv glClearNamedFramebufferiv;
	fp_glHistogram glHistogram;
	fp_glGetObjectParameterfvARB glGetObjectParameterfvARB;
	fp_glGetLightxvOES glGetLightxvOES;
	fp_glBindVideoCaptureStreamBufferNV glBindVideoCaptureStreamBufferNV;
	fp_glDrawRangeElementArrayAPPLE glDrawRangeElementArrayAPPLE;
	fp_glGetTexParameterPointervAPPLE glGetTexParameterPointervAPPLE;
	fp_glMatrixPopEXT glMatrixPopEXT;
	fp_glActiveShaderProgramEXT glActiveShaderProgramEXT;
	fp_glVertexStream1sATI glVertexStream1sATI;
	fp_glGetnPixelMapuivARB glGetnPixelMapuivARB;
	fp_glMultiTexEnviEXT glMultiTexEnviEXT;
	fp_glVertexAttribI2iEXT glVertexAttribI2iEXT;
	fp_glProgramParameter4fvNV glProgramParameter4fvNV;
	fp_glNamedFramebufferSampleLocationsfvNV glNamedFramebufferSampleLocationsfvNV;
	fp_glRectxvOES glRectxvOES;
	fp_glGetVariantIntegervEXT glGetVariantIntegervEXT;
	fp_glFragmentCoverageColorNV glFragmentCoverageColorNV;
	fp_glGetPerfMonitorGroupsAMD glGetPerfMonitorGroupsAMD;
	fp_glMultTransposeMatrixfARB glMultTransposeMatrixfARB;
	fp_glVertexAttribI2ivEXT glVertexAttribI2ivEXT;
	fp_glReplacementCodeuiColor4fNormal3fVertex3fvSUN glReplacementCodeuiColor4fNormal3fVertex3fvSUN;
	fp_glDeleteStatesNV glDeleteStatesNV;
	fp_glProgramUniform4dv glProgramUniform4dv;
	fp_glEdgeFlagPointerEXT glEdgeFlagPointerEXT;
	fp_glVideoCaptureStreamParameterivNV glVideoCaptureStreamParameterivNV;
	fp_glVertexStream4iATI glVertexStream4iATI;
	fp_glVDPAUFiniNV glVDPAUFiniNV;
	fp_glMakeBufferNonResidentNV glMakeBufferNonResidentNV;
	fp_glMultiTexCoord2fvARB glMultiTexCoord2fvARB;
	fp_glStencilStrokePathNV glStencilStrokePathNV;
	fp_glVariantuivEXT glVariantuivEXT;
	fp_glCheckNamedFramebufferStatus glCheckNamedFramebufferStatus;
	fp_glSecondaryColorPointerListIBM glSecondaryColorPointerListIBM;
	fp_glMultiTexCoord1sARB glMultiTexCoord1sARB;
	fp_glGetDebugMessageLogKHR glGetDebugMessageLogKHR;
	fp_glConvolutionParameterfv glConvolutionParameterfv;
	fp_glUniform4i64ARB glUniform4i64ARB;
	fp_glTextureNormalEXT glTextureNormalEXT;
	fp_glProgramUniform2uiEXT glProgramUniform2uiEXT;
	fp_glCompressedMultiTexImage3DEXT glCompressedMultiTexImage3DEXT;
	fp_glGetInstrumentsSGIX glGetInstrumentsSGIX;
	fp_glProgramUniformMatrix4x3fvEXT glProgramUniformMatrix4x3fvEXT;
	fp_glProgramUniform3dEXT glProgramUniform3dEXT;
	fp_glMultiTexCoord2hNV glMultiTexCoord2hNV;
	fp_glGetConvolutionFilterEXT glGetConvolutionFilterEXT;
	fp_glVertexAttrib2hNV glVertexAttrib2hNV;
	fp_glCurrentPaletteMatrixARB glCurrentPaletteMatrixARB;
	fp_glFogCoordPointerEXT glFogCoordPointerEXT;
	fp_glCreateRenderbuffers glCreateRenderbuffers;
	fp_glGetBufferParameterui64vNV glGetBufferParameterui64vNV;
	fp_glVertexAttribI4bvEXT glVertexAttribI4bvEXT;
	fp_glEnableClientStateIndexedEXT glEnableClientStateIndexedEXT;
	fp_glProgramUniform4i64ARB glProgramUniform4i64ARB;
	fp_glMatrixLoadIdentityEXT glMatrixLoadIdentityEXT;
	fp_glTextureColorMaskSGIS glTextureColorMaskSGIS;
	fp_glCreateShaderProgramEXT glCreateShaderProgramEXT;
	fp_glBufferStorage glBufferStorage;
	fp_glMakeNamedBufferNonResidentNV glMakeNamedBufferNonResidentNV;
	fp_glRenderbufferStorageMultisampleEXT glRenderbufferStorageMultisampleEXT;
	fp_glGetFloati_v glGetFloati_v;
	fp_glUniform2ui64ARB glUniform2ui64ARB;
	fp_glBindVertexShaderEXT glBindVertexShaderEXT;
	fp_glVertexStream1svATI glVertexStream1svATI;
	fp_glVertexStream3fATI glVertexStream3fATI;
	fp_glNamedFramebufferDrawBuffers glNamedFramebufferDrawBuffers;
	fp_glUniform2ui64vNV glUniform2ui64vNV;
	fp_glTexCoordPointervINTEL glTexCoordPointervINTEL;
	fp_glNormalPointerEXT glNormalPointerEXT;
	fp_glVertexAttrib4hNV glVertexAttrib4hNV;
	fp_glCompressedTextureSubImage3D glCompressedTextureSubImage3D;
	fp_glAsyncMarkerSGIX glAsyncMarkerSGIX;
	fp_glTextureStorageSparseAMD glTextureStorageSparseAMD;
	fp_glGetConvolutionParameterivEXT glGetConvolutionParameterivEXT;
	fp_glEndPerfQueryINTEL glEndPerfQueryINTEL;
	fp_glPrioritizeTexturesEXT glPrioritizeTexturesEXT;
	fp_glResetHistogram glResetHistogram;
	fp_glGetOcclusionQueryivNV glGetOcclusionQueryivNV;
	fp_glUniform1uiEXT glUniform1uiEXT;
	fp_glTexSubImage2DEXT glTexSubImage2DEXT;
	fp_glProgramUniform2uiv glProgramUniform2uiv;
	fp_glMultiTexCoord2iARB glMultiTexCoord2iARB;
	fp_glGenerateMultiTexMipmapEXT glGenerateMultiTexMipmapEXT;
	fp_glWindowPos3dvMESA glWindowPos3dvMESA;
	fp_glLabelObjectEXT glLabelObjectEXT;
	fp_glProgramUniform1uiv glProgramUniform1uiv;
	fp_glMultiTexEnvfEXT glMultiTexEnvfEXT;
	fp_glVertex4xOES glVertex4xOES;
	fp_glVertexAttribI2uivEXT glVertexAttribI2uivEXT;
	fp_glNamedProgramLocalParameter4fvEXT glNamedProgramLocalParameter4fvEXT;
	fp_glPointParameterfvSGIS glPointParameterfvSGIS;
	fp_glGetPixelTransformParameterfvEXT glGetPixelTransformParameterfvEXT;
	fp_glProgramUniformMatrix2x4fv glProgramUniformMatrix2x4fv;
	fp_glAreProgramsResidentNV glAreProgramsResidentNV;
	fp_glColorTable glColorTable;
	fp_glBeginQueryIndexed glBeginQueryIndexed;
	fp_glVertexStream1dvATI glVertexStream1dvATI;
	fp_glFlushMappedBufferRangeAPPLE glFlushMappedBufferRangeAPPLE;
	fp_glVertexAttribs1dvNV glVertexAttribs1dvNV;
	fp_glVertexStream2sATI glVertexStream2sATI;
	fp_glGetnSeparableFilterARB glGetnSeparableFilterARB;
	fp_glProgramUniform2dv glProgramUniform2dv;
	fp_glActiveStencilFaceEXT glActiveStencilFaceEXT;
	fp_glProgramUniform4dEXT glProgramUniform4dEXT;
	fp_glPointSizexOES glPointSizexOES;
	fp_glBindParameterEXT glBindParameterEXT;
	fp_glBlendParameteriNV glBlendParameteriNV;
	fp_glPointParameterxOES glPointParameterxOES;
	fp_glNamedProgramLocalParameter4dvEXT glNamedProgramLocalParameter4dvEXT;
	fp_glGetTextureParameterfvEXT glGetTextureParameterfvEXT;
	fp_glGetPathMetricsNV glGetPathMetricsNV;
	fp_glMatrixLoad3x3fNV glMatrixLoad3x3fNV;
	fp_glMultiTexCoord2fARB glMultiTexCoord2fARB;
	fp_glWeightdvARB glWeightdvARB;
	fp_glIsTransformFeedbackNV glIsTransformFeedbackNV;
	fp_glGetUniformOffsetEXT glGetUniformOffsetEXT;
	fp_glGetnCompressedTexImageARB glGetnCompressedTexImageARB;
	fp_glMatrixLoaddEXT glMatrixLoaddEXT;
	fp_glGetPathLengthNV glGetPathLengthNV;
	fp_glProgramUniformMatrix3dv glProgramUniformMatrix3dv;
	fp_glVertexAttrib4dARB glVertexAttrib4dARB;
	fp_glGetHistogramEXT glGetHistogramEXT;
	fp_glVertexAttrib4NuivARB glVertexAttrib4NuivARB;
	fp_glMapGrid2xOES glMapGrid2xOES;
	fp_glWindowPos2fvARB glWindowPos2fvARB;
	fp_glEnableIndexedEXT glEnableIndexedEXT;
	fp_glTexCoord1bvOES glTexCoord1bvOES;
	fp_glUniform2uiEXT glUniform2uiEXT;
	fp_glReplacementCodePointerSUN glReplacementCodePointerSUN;
	fp_glLoadTransposeMatrixdARB glLoadTransposeMatrixdARB;
	fp_glVertexArrayVertexAttribIOffsetEXT glVertexArrayVertexAttribIOffsetEXT;
	fp_glProgramUniform3fEXT glProgramUniform3fEXT;
	fp_glWindowPos3dMESA glWindowPos3dMESA;
	fp_glNormalStream3fvATI glNormalStream3fvATI;
	fp_glUniform4ui64ARB glUniform4ui64ARB;
	fp_glTextureRenderbufferEXT glTextureRenderbufferEXT;
	fp_glGetSubroutineUniformLocation glGetSubroutineUniformLocation;
	fp_glGetFramebufferParameteriv glGetFramebufferParameteriv;
	fp_glGetPointervEXT glGetPointervEXT;
	fp_glProgramUniformMatrix3dvEXT glProgramUniformMatrix3dvEXT;
	fp_glSeparableFilter2D glSeparableFilter2D;
	fp_glVertex3xvOES glVertex3xvOES;
	fp_glReplacementCodeuivSUN glReplacementCodeuivSUN;
	fp_glVertexAttribI3uiEXT glVertexAttribI3uiEXT;
	fp_glVertexAttribL4dvEXT glVertexAttribL4dvEXT;
	fp_glUniform2ui64vARB glUniform2ui64vARB;
	fp_glMakeNamedBufferResidentNV glMakeNamedBufferResidentNV;
	fp_glPathGlyphIndexRangeNV glPathGlyphIndexRangeNV;
	fp_glEnableVertexAttribAPPLE glEnableVertexAttribAPPLE;
	fp_glProgramEnvParameterI4ivNV glProgramEnvParameterI4ivNV;
	fp_glMultiTexCoord1fARB glMultiTexCoord1fARB;
	fp_glMultiTexParameterfEXT glMultiTexParameterfEXT;
	fp_glNamedFramebufferTextureLayer glNamedFramebufferTextureLayer;
	fp_glGetVertexArrayIntegervEXT glGetVertexArrayIntegervEXT;
	fp_glVertexAttrib3dARB glVertexAttrib3dARB;
	fp_glVDPAUIsSurfaceNV glVDPAUIsSurfaceNV;
	fp_glIsAsyncMarkerSGIX glIsAsyncMarkerSGIX;
	fp_glFragmentMaterialfvSGIX glFragmentMaterialfvSGIX;
	fp_glCreatePerfQueryINTEL glCreatePerfQueryINTEL;
	fp_glIsCommandListNV glIsCommandListNV;
	fp_glConvolutionParameteriEXT glConvolutionParameteriEXT;
	fp_glTexParameterIuivEXT glTexParameterIuivEXT;
	fp_glProgramUniformMatrix4fv glProgramUniformMatrix4fv;
	fp_glVertexAttribL3dEXT glVertexAttribL3dEXT;
	fp_glGetUniformLocationARB glGetUniformLocationARB;
	fp_glPathParameterfvNV glPathParameterfvNV;
	fp_glGetDoublei_v glGetDoublei_v;
	fp_glVertexArrayRangeAPPLE glVertexArrayRangeAPPLE;
	fp_glBindBufferOffsetEXT glBindBufferOffsetEXT;
	fp_glWeightfvARB glWeightfvARB;
	fp_glVDPAUMapSurfacesNV glVDPAUMapSurfacesNV;
	fp_glProgramLocalParameter4fvARB glProgramLocalParameter4fvARB;
	fp_glGetTransformFeedbackVaryingNV glGetTransformFeedbackVaryingNV;
	fp_glColorFragmentOp2ATI glColorFragmentOp2ATI;
	fp_glGetTextureHandleNV glGetTextureHandleNV;
	fp_glDepthRangef glDepthRangef;
	fp_glGetFragmentMaterialivSGIX glGetFragmentMaterialivSGIX;
	fp_glVideoCaptureStreamParameterfvNV glVideoCaptureStreamParameterfvNV;
	fp_glDeleteProgramsARB glDeleteProgramsARB;
	fp_glWindowPos3fvARB glWindowPos3fvARB;
	fp_glFeedbackBufferxOES glFeedbackBufferxOES;
	fp_glGetTexBumpParameterfvATI glGetTexBumpParameterfvATI;
	fp_glBindProgramARB glBindProgramARB;
	fp_glProgramUniform3ui64vARB glProgramUniform3ui64vARB;
	fp_glProgramUniformMatrix2dv glProgramUniformMatrix2dv;
	fp_glMultiTexCoord2hvNV glMultiTexCoord2hvNV;
	fp_glSampleCoverageARB glSampleCoverageARB;
	fp_glProgramUniform2ui64vARB glProgramUniform2ui64vARB;
	fp_glPixelDataRangeNV glPixelDataRangeNV;
	fp_glVertexStream3svATI glVertexStream3svATI;
	fp_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN;
	fp_glTexCoord3hvNV glTexCoord3hvNV;
	fp_glIndexFuncEXT glIndexFuncEXT;
	fp_glPointParameteriNV glPointParameteriNV;
	fp_glGetFramebufferParameterivEXT glGetFramebufferParameterivEXT;
	fp_glGetInternalformativ glGetInternalformativ;
	fp_glNamedFramebufferTexture3DEXT glNamedFramebufferTexture3DEXT;
	fp_glTexImage4DSGIS glTexImage4DSGIS;
	fp_glProgramUniformMatrix3fvEXT glProgramUniformMatrix3fvEXT;
	fp_glEnableVertexArrayEXT glEnableVertexArrayEXT;
	fp_glColorTableParameterfvSGI glColorTableParameterfvSGI;
	fp_glSpriteParameterivSGIX glSpriteParameterivSGIX;
	fp_glGetColorTable glGetColorTable;
	fp_glMultiTexCoord4ivARB glMultiTexCoord4ivARB;
	fp_glDeletePathsNV glDeletePathsNV;
	fp_glPrimitiveRestartIndexNV glPrimitiveRestartIndexNV;
	fp_glFragmentLightfvSGIX glFragmentLightfvSGIX;
	fp_glTexCoordPointerListIBM glTexCoordPointerListIBM;
	fp_glRectxOES glRectxOES;
	fp_glCopyNamedBufferSubData glCopyNamedBufferSubData;
	fp_glGenProgramsNV glGenProgramsNV;
	fp_glFragmentLightfSGIX glFragmentLightfSGIX;
	fp_glTexStorage3D glTexStorage3D;
	fp_glTextureParameteriv glTextureParameteriv;
	fp_glNamedBufferDataEXT glNamedBufferDataEXT;
	fp_glMultiTexCoord3fvARB glMultiTexCoord3fvARB;
	fp_glSubpixelPrecisionBiasNV glSubpixelPrecisionBiasNV;
	fp_glNamedFramebufferTexture glNamedFramebufferTexture;
	fp_glVertexAttrib4NsvARB glVertexAttrib4NsvARB;
	fp_glIsImageHandleResidentARB glIsImageHandleResidentARB;
	fp_glConvolutionParameterfEXT glConvolutionParameterfEXT;
	fp_glProgramUniformMatrix4x3fv glProgramUniformMatrix4x3fv;
	fp_glFogCoordfvEXT glFogCoordfvEXT;
	fp_glVertexAttribL3i64NV glVertexAttribL3i64NV;
	fp_glStencilClearTagEXT glStencilClearTagEXT;
	fp_glMultiTexGendEXT glMultiTexGendEXT;
	fp_glUniform4ui64vNV glUniform4ui64vNV;
	fp_glDebugMessageEnableAMD glDebugMessageEnableAMD;
	fp_glProgramUniform2ui glProgramUniform2ui;
	fp_glCopyTexSubImage2DEXT glCopyTexSubImage2DEXT;
	fp_glGenRenderbuffersEXT glGenRenderbuffersEXT;
	fp_glNamedProgramLocalParameterI4ivEXT glNamedProgramLocalParameterI4ivEXT;
	fp_glGetMultiTexParameterIuivEXT glGetMultiTexParameterIuivEXT;
	fp_glNamedFramebufferDrawBuffer glNamedFramebufferDrawBuffer;
	fp_glUniform4ivARB glUniform4ivARB;
	fp_glMatrixOrthoEXT glMatrixOrthoEXT;
	fp_glVertexArrayVertexBuffer glVertexArrayVertexBuffer;
	fp_glProgramLocalParametersI4ivNV glProgramLocalParametersI4ivNV;
	fp_glProgramUniform4ui64vNV glProgramUniform4ui64vNV;
	fp_glGetNamedStringivARB glGetNamedStringivARB;
	fp_glVertexAttribL1i64vNV glVertexAttribL1i64vNV;
	fp_glTransformFeedbackBufferBase glTransformFeedbackBufferBase;
	fp_glPointParameterivNV glPointParameterivNV;
	fp_glGetDetailTexFuncSGIS glGetDetailTexFuncSGIS;
	fp_glReplacementCodeuiColor3fVertex3fvSUN glReplacementCodeuiColor3fVertex3fvSUN;
	fp_glProgramLocalParameter4fARB glProgramLocalParameter4fARB;
	fp_glNamedFramebufferTextureLayerEXT glNamedFramebufferTextureLayerEXT;
	fp_glMultiTexGenfvEXT glMultiTexGenfvEXT;
	fp_glGetNamedBufferSubData glGetNamedBufferSubData;
	fp_glStencilFuncSeparateATI glStencilFuncSeparateATI;
	fp_glProgramUniform2iv glProgramUniform2iv;
	fp_glGetTransformFeedbackiv glGetTransformFeedbackiv;
	fp_glListParameterivSGIX glListParameterivSGIX;
	fp_glCreateQueries glCreateQueries;
	fp_glLoadTransposeMatrixxOES glLoadTransposeMatrixxOES;
	fp_glProgramUniform3i64NV glProgramUniform3i64NV;
	fp_glGetTextureHandleARB glGetTextureHandleARB;
	fp_glAlphaFragmentOp1ATI glAlphaFragmentOp1ATI;
	fp_glColorTableParameteriv glColorTableParameteriv;
	fp_glDebugMessageControlKHR glDebugMessageControlKHR;
	fp_glMultiTexImage3DEXT glMultiTexImage3DEXT;
	fp_glCoverageModulationTableNV glCoverageModulationTableNV;
	fp_glMultiTexCoord4svARB glMultiTexCoord4svARB;
	fp_glProgramUniformMatrix3x4dvEXT glProgramUniformMatrix3x4dvEXT;
	fp_glProgramUniformMatrix4x3dvEXT glProgramUniformMatrix4x3dvEXT;
	fp_glGetActiveVaryingNV glGetActiveVaryingNV;
	fp_glDeformationMap3dSGIX glDeformationMap3dSGIX;
	fp_glUniform1i64vARB glUniform1i64vARB;
	fp_glGetFirstPerfQueryIdINTEL glGetFirstPerfQueryIdINTEL;
	fp_glProgramUniform1ui64vNV glProgramUniform1ui64vNV;
	fp_glTextureMaterialEXT glTextureMaterialEXT;
	fp_glInterpolatePathsNV glInterpolatePathsNV;
	fp_glTextureBufferRange glTextureBufferRange;
	fp_glGetIntegerui64vNV glGetIntegerui64vNV;
	fp_glGetPixelTransformParameterivEXT glGetPixelTransformParameterivEXT;
	fp_glTexCoord4xvOES glTexCoord4xvOES;
	fp_glGetVariantBooleanvEXT glGetVariantBooleanvEXT;
	fp_glGetVertexAttribdvARB glGetVertexAttribdvARB;
	fp_glProgramUniform4i64vNV glProgramUniform4i64vNV;
	fp_glDrawArraysInstancedEXT glDrawArraysInstancedEXT;
	fp_glDisableClientStateIndexedEXT glDisableClientStateIndexedEXT;
	fp_glMultiDrawArraysIndirectBindlessNV glMultiDrawArraysIndirectBindlessNV;
	fp_glReadnPixelsKHR glReadnPixelsKHR;
	fp_glGetInternalformati64v glGetInternalformati64v;
	fp_glShaderSourceARB glShaderSourceARB;
	fp_glShaderOp3EXT glShaderOp3EXT;
	fp_glWindowPos2dvMESA glWindowPos2dvMESA;
	fp_glProvokingVertexEXT glProvokingVertexEXT;
	fp_glVariantubvEXT glVariantubvEXT;
	fp_glGetColorTableParameterivEXT glGetColorTableParameterivEXT;
	fp_glPresentFrameDualFillNV glPresentFrameDualFillNV;
	fp_glGenVertexShadersEXT glGenVertexShadersEXT;
	fp_glProgramUniformHandleui64vARB glProgramUniformHandleui64vARB;
	fp_glDepthRangefOES glDepthRangefOES;
	fp_glGetVariantPointervEXT glGetVariantPointervEXT;
	fp_glStencilFillPathNV glStencilFillPathNV;
	fp_glWindowPos3iARB glWindowPos3iARB;
	fp_glWindowPos3fvMESA glWindowPos3fvMESA;
	fp_glDepthRangexOES glDepthRangexOES;
	fp_glVertex4xvOES glVertex4xvOES;
	fp_glTexStorage3DMultisample glTexStorage3DMultisample;
	fp_glGetNamedProgramLocalParameterfvEXT glGetNamedProgramLocalParameterfvEXT;
	fp_glStencilOpValueAMD glStencilOpValueAMD;
	fp_glProgramVertexLimitNV glProgramVertexLimitNV;
	fp_glUniform3i64NV glUniform3i64NV;
	fp_glProgramUniform3uivEXT glProgramUniform3uivEXT;
	fp_glVertexAttribs3svNV glVertexAttribs3svNV;
	fp_glMakeTextureHandleResidentNV glMakeTextureHandleResidentNV;
	fp_glVertexBlendEnvfATI glVertexBlendEnvfATI;
	fp_glIsFenceAPPLE glIsFenceAPPLE;
	fp_glCombinerInputNV glCombinerInputNV;
	fp_glWindowPos4fMESA glWindowPos4fMESA;
	fp_glStopInstrumentsSGIX glStopInstrumentsSGIX;
	fp_glMapVertexAttrib2dAPPLE glMapVertexAttrib2dAPPLE;
	fp_glCopyTextureImage2DEXT glCopyTextureImage2DEXT;
	fp_glSecondaryColor3bvEXT glSecondaryColor3bvEXT;
	fp_glMultiTexCoord4fARB glMultiTexCoord4fARB;
	fp_glTangent3bvEXT glTangent3bvEXT;
	fp_glMatrixIndexubvARB glMatrixIndexubvARB;
	fp_glProgramUniform4fv glProgramUniform4fv;
	fp_glGetVertexAttribLui64vNV glGetVertexAttribLui64vNV;
	fp_glGetProgramStringARB glGetProgramStringARB;
	fp_glTexStorage2D glTexStorage2D;
	fp_glLineWidthxOES glLineWidthxOES;
	fp_glProgramUniformMatrix2fvEXT glProgramUniformMatrix2fvEXT;
	fp_glGetTextureParameterIuivEXT glGetTextureParameterIuivEXT;
	fp_glGetMultiTexEnvivEXT glGetMultiTexEnvivEXT;
	fp_glPixelTexGenParameterivSGIS glPixelTexGenParameterivSGIS;
	fp_glCompressedTextureSubImage1DEXT glCompressedTextureSubImage1DEXT;
	fp_glBlendColorEXT glBlendColorEXT;
	fp_glResetMinmax glResetMinmax;
	fp_glGetnUniformivARB glGetnUniformivARB;
	fp_glVertexBlendARB glVertexBlendARB;
	fp_glGetVaryingLocationNV glGetVaryingLocationNV;
	fp_glGetMapAttribParameterivNV glGetMapAttribParameterivNV;
	fp_glUniform2i64ARB glUniform2i64ARB;
	fp_glGetLightxOES glGetLightxOES;
	fp_glPrimitiveBoundingBoxARB glPrimitiveBoundingBoxARB;
	fp_glVertexArrayNormalOffsetEXT glVertexArrayNormalOffsetEXT;
	fp_glGetBufferParameterivARB glGetBufferParameterivARB;
	fp_glGetTextureParameterfv glGetTextureParameterfv;
	fp_glDrawMeshArraysSUN glDrawMeshArraysSUN;
	fp_glVertexAttrib4dNV glVertexAttrib4dNV;
	fp_glGetMultisamplefvNV glGetMultisamplefvNV;
	fp_glMapObjectBufferATI glMapObjectBufferATI;
	fp_glGetPathCommandsNV glGetPathCommandsNV;
	fp_glVertexArrayTexCoordOffsetEXT glVertexArrayTexCoordOffsetEXT;
	fp_glGetHistogram glGetHistogram;
	fp_glColorFormatNV glColorFormatNV;
	fp_glProgramUniformui64NV glProgramUniformui64NV;
	fp_glProgramUniformMatrix4x2fvEXT glProgramUniformMatrix4x2fvEXT;
	fp_glLoadMatrixxOES glLoadMatrixxOES;
	fp_glVariantbvEXT glVariantbvEXT;
	fp_glVertexAttribL2i64NV glVertexAttribL2i64NV;
	fp_glBindTextures glBindTextures;
	fp_glCombinerParameteriNV glCombinerParameteriNV;
	fp_glMatrixRotatefEXT glMatrixRotatefEXT;
	fp_glGetClipPlanexOES glGetClipPlanexOES;
	fp_glSecondaryColor3uivEXT glSecondaryColor3uivEXT;
	fp_glGetPerfQueryInfoINTEL glGetPerfQueryInfoINTEL;
	fp_glUniform2fARB glUniform2fARB;
	fp_glBindBufferRangeEXT glBindBufferRangeEXT;
	fp_glVertexAttribs1svNV glVertexAttribs1svNV;
	fp_glMapBufferARB glMapBufferARB;
	fp_glGetPathSpacingNV glGetPathSpacingNV;
	fp_glUniform4dv glUniform4dv;
	fp_glGlobalAlphaFactordSUN glGlobalAlphaFactordSUN;
	fp_glProgramUniform3dv glProgramUniform3dv;
	fp_glGetShaderSourceARB glGetShaderSourceARB;
	fp_glVertexAttrib3dvARB glVertexAttrib3dvARB;
	fp_glInvalidateBufferData glInvalidateBufferData;
	fp_glMatrixLoad3x2fNV glMatrixLoad3x2fNV;
	fp_glCompressedTextureSubImage1D glCompressedTextureSubImage1D;
	fp_glTexCoord3xvOES glTexCoord3xvOES;
	fp_glGenTexturesEXT glGenTexturesEXT;
	fp_glTangent3iEXT glTangent3iEXT;
	fp_glClearTexImage glClearTexImage;
	fp_glBinormal3bvEXT glBinormal3bvEXT;
	fp_glGetnPixelMapusvARB glGetnPixelMapusvARB;
	fp_glClearNamedBufferDataEXT glClearNamedBufferDataEXT;
	fp_glUniformMatrix4dv glUniformMatrix4dv;
	fp_glWindowPos3fMESA glWindowPos3fMESA;
	fp_glGetTextureLevelParameterfvEXT glGetTextureLevelParameterfvEXT;
	fp_glGetHistogramParameterxvOES glGetHistogramParameterxvOES;
	fp_glMakeImageHandleNonResidentNV glMakeImageHandleNonResidentNV;
	fp_glTexSubImage1DEXT glTexSubImage1DEXT;
	fp_glNormalStream3dATI glNormalStream3dATI;
	fp_glVertexAttribL4i64vNV glVertexAttribL4i64vNV;
	fp_glCopyTextureSubImage1DEXT glCopyTextureSubImage1DEXT;
	fp_glNamedFramebufferReadBuffer glNamedFramebufferReadBuffer;
	fp_glUniform2i64vARB glUniform2i64vARB;
	fp_glVertexAttribI1uivEXT glVertexAttribI1uivEXT;
	fp_glBeginQueryARB glBeginQueryARB;
	fp_glUniform1iARB glUniform1iARB;
	fp_glVertex4bvOES glVertex4bvOES;
	fp_glTestFenceNV glTestFenceNV;
	fp_glBindTransformFeedback glBindTransformFeedback;
	fp_glCopyMultiTexSubImage1DEXT glCopyMultiTexSubImage1DEXT;
	fp_glClipPlanexOES glClipPlanexOES;
	fp_glUseProgramStagesEXT glUseProgramStagesEXT;
	fp_glTexCoord1hNV glTexCoord1hNV;
	fp_glGenFencesNV glGenFencesNV;
	fp_glMultiTexCoord1hvNV glMultiTexCoord1hvNV;
	fp_glWeightbvARB glWeightbvARB;
	fp_glBeginConditionalRenderNVX glBeginConditionalRenderNVX;
	fp_glColorTableParameterfv glColorTableParameterfv;
	fp_glVertexArrayVertexOffsetEXT glVertexArrayVertexOffsetEXT;
	fp_glFinishObjectAPPLE glFinishObjectAPPLE;
	fp_glReplacementCodeuiTexCoord2fVertex3fvSUN glReplacementCodeuiTexCoord2fVertex3fvSUN;
	fp_glUniformMatrix2dv glUniformMatrix2dv;
	fp_glSecondaryColor3ivEXT glSecondaryColor3ivEXT;
	fp_glGetTransformFeedbacki64_v glGetTransformFeedbacki64_v;
	fp_glDeformationMap3fSGIX glDeformationMap3fSGIX;
	fp_glGenAsyncMarkersSGIX glGenAsyncMarkersSGIX;
	fp_glDisableIndexedEXT glDisableIndexedEXT;
	fp_glVertexWeightfvEXT glVertexWeightfvEXT;
	fp_glGetProgramLocalParameterIivNV glGetProgramLocalParameterIivNV;
	fp_glTexCoord4fColor4fNormal3fVertex4fSUN glTexCoord4fColor4fNormal3fVertex4fSUN;
	fp_glCompressedTexImage3DARB glCompressedTexImage3DARB;
	fp_glProgramParameter4fNV glProgramParameter4fNV;
	fp_glConvolutionParameterxOES glConvolutionParameterxOES;
	fp_glInsertComponentEXT glInsertComponentEXT;
	fp_glCreateTextures glCreateTextures;
	fp_glCreateBuffers glCreateBuffers;
	fp_glMultiTexCoord2xvOES glMultiTexCoord2xvOES;
	fp_glTexGenxvOES glTexGenxvOES;
	fp_glBeginTransformFeedbackEXT glBeginTransformFeedbackEXT;
	fp_glMultiTexParameteriEXT glMultiTexParameteriEXT;
	fp_glFreeObjectBufferATI glFreeObjectBufferATI;
	fp_glBlendBarrierNV glBlendBarrierNV;
	fp_glUniform4i64vNV glUniform4i64vNV;
	fp_glGetnUniformuivARB glGetnUniformuivARB;
	fp_glProgramEnvParameters4fvEXT glProgramEnvParameters4fvEXT;
	fp_glBlendFuncSeparateEXT glBlendFuncSeparateEXT;
	fp_glConvolutionParameterivEXT glConvolutionParameterivEXT;
	fp_glPixelTexGenSGIX glPixelTexGenSGIX;
	fp_glUniformMatrix4x3dv glUniformMatrix4x3dv;
	fp_glGetVideoCaptureStreamivNV glGetVideoCaptureStreamivNV;
	fp_glMakeImageHandleNonResidentARB glMakeImageHandleNonResidentARB;
	fp_glSecondaryColor3dEXT glSecondaryColor3dEXT;
	fp_glBinormal3fvEXT glBinormal3fvEXT;
	fp_glVertexArrayVertexAttribDivisorEXT glVertexArrayVertexAttribDivisorEXT;
	fp_glArrayElementEXT glArrayElementEXT;
	fp_glIndexxOES glIndexxOES;
	fp_glUniform3uivEXT glUniform3uivEXT;
	fp_glPopGroupMarkerEXT glPopGroupMarkerEXT;
	fp_glClearNamedFramebufferuiv glClearNamedFramebufferuiv;
	fp_glSetLocalConstantEXT glSetLocalConstantEXT;
	fp_glProgramUniform1ui64NV glProgramUniform1ui64NV;
	fp_glColor4hvNV glColor4hvNV;
	fp_glDispatchCompute glDispatchCompute;
	fp_glFragmentColorMaterialSGIX glFragmentColorMaterialSGIX;
	fp_glProgramUniformMatrix3x4fv glProgramUniformMatrix3x4fv;
	fp_glWindowPos4iMESA glWindowPos4iMESA;
	fp_glPollAsyncSGIX glPollAsyncSGIX;
	fp_glGetTextureParameterIuiv glGetTextureParameterIuiv;
	fp_glMultiTexCoord1xOES glMultiTexCoord1xOES;
	fp_glProgramUniformMatrix4dv glProgramUniformMatrix4dv;
	fp_glFramebufferTexture1DEXT glFramebufferTexture1DEXT;
	fp_glImageTransformParameterfHP glImageTransformParameterfHP;
	fp_glNamedProgramLocalParametersI4ivEXT glNamedProgramLocalParametersI4ivEXT;
	fp_glGetSeparableFilterEXT glGetSeparableFilterEXT;
	fp_glMultiTexCoord3iARB glMultiTexCoord3iARB;
	fp_glRasterPos4xvOES glRasterPos4xvOES;
	fp_glDrawTransformFeedbackStream glDrawTransformFeedbackStream;
	fp_glVertex3hvNV glVertex3hvNV;
	fp_glVertexArrayMultiTexCoordOffsetEXT glVertexArrayMultiTexCoordOffsetEXT;
	fp_glAccumxOES glAccumxOES;
	fp_glShaderBinary glShaderBinary;
	fp_glGetMultiTexGenivEXT glGetMultiTexGenivEXT;
	fp_glSwizzleEXT glSwizzleEXT;
	fp_glCreateStatesNV glCreateStatesNV;
	fp_glClearDepthdNV glClearDepthdNV;
	fp_glGetNamedProgramLocalParameterdvEXT glGetNamedProgramLocalParameterdvEXT;
	fp_glBindMultiTextureEXT glBindMultiTextureEXT;
	fp_glConvolutionFilter1DEXT glConvolutionFilter1DEXT;
	fp_glDisableVertexArrayEXT glDisableVertexArrayEXT;
	fp_glProgramUniform3ui64NV glProgramUniform3ui64NV;
	fp_glMultiTexParameterIivEXT glMultiTexParameterIivEXT;
	fp_glBindLightParameterEXT glBindLightParameterEXT;
	fp_glVertexAttrib2sNV glVertexAttrib2sNV;
	fp_glTexBufferEXT glTexBufferEXT;
	fp_glVertexStream2fATI glVertexStream2fATI;
	fp_glDebugMessageCallbackAMD glDebugMessageCallbackAMD;
	fp_glMultiTexCoord2dARB glMultiTexCoord2dARB;
	fp_glEndQueryIndexed glEndQueryIndexed;
	fp_glNormalStream3sATI glNormalStream3sATI;
	fp_glProgramParameteriARB glProgramParameteriARB;
	fp_glTexEnvxOES glTexEnvxOES;
	fp_glProgramUniform1iv glProgramUniform1iv;
	fp_glDisableVertexAttribAPPLE glDisableVertexAttribAPPLE;
	fp_glMultiTexSubImage3DEXT glMultiTexSubImage3DEXT;
	fp_glProgramUniformHandleui64vNV glProgramUniformHandleui64vNV;
	fp_glMultiDrawElementsIndirectAMD glMultiDrawElementsIndirectAMD;
	fp_glGetLocalConstantBooleanvEXT glGetLocalConstantBooleanvEXT;
	fp_glUniformMatrix3x2dv glUniformMatrix3x2dv;
	fp_glDeleteAsyncMarkersSGIX glDeleteAsyncMarkersSGIX;
	fp_glProgramUniformMatrix2x3dv glProgramUniformMatrix2x3dv;
	fp_glVideoCaptureNV glVideoCaptureNV;
	fp_glTexCoord3xOES glTexCoord3xOES;
	fp_glLoadTransposeMatrixfARB glLoadTransposeMatrixfARB;
	fp_glImageTransformParameteriHP glImageTransformParameteriHP;
	fp_glMultiTexCoord4xOES glMultiTexCoord4xOES;
	fp_glGetMapParameterivNV glGetMapParameterivNV;
	fp_glUniform3ui64NV glUniform3ui64NV;
	fp_glCombinerParameterfvNV glCombinerParameterfvNV;
	fp_glCopyConvolutionFilter2D glCopyConvolutionFilter2D;
	fp_glMultiTexCoord3xOES glMultiTexCoord3xOES;
	fp_glBeginConditionalRenderNV glBeginConditionalRenderNV;
	fp_glPathFogGenNV glPathFogGenNV;
	fp_glStencilThenCoverFillPathNV glStencilThenCoverFillPathNV;
	fp_glVertexArrayIndexOffsetEXT glVertexArrayIndexOffsetEXT;
	fp_glProgramBufferParametersIuivNV glProgramBufferParametersIuivNV;
	fp_glPixelTransformParameterivEXT glPixelTransformParameterivEXT;
	fp_glDisableClientStateiEXT glDisableClientStateiEXT;
	fp_glTexBufferARB glTexBufferARB;
	fp_glGetLocalConstantIntegervEXT glGetLocalConstantIntegervEXT;
	fp_glProgramUniform3i glProgramUniform3i;
	fp_glMultiDrawElementsIndirectBindlessCountNV glMultiDrawElementsIndirectBindlessCountNV;
	fp_glGetBufferPointervARB glGetBufferPointervARB;
	fp_glMultiTexParameterIuivEXT glMultiTexParameterIuivEXT;
	fp_glMultMatrixxOES glMultMatrixxOES;
	fp_glColorPointerListIBM glColorPointerListIBM;
	fp_glStencilThenCoverFillPathInstancedNV glStencilThenCoverFillPathInstancedNV;
	fp_glProgramUniform3d glProgramUniform3d;
	fp_glMapVertexAttrib1dAPPLE glMapVertexAttrib1dAPPLE;
	fp_glProgramLocalParameters4fvEXT glProgramLocalParameters4fvEXT;
	fp_glEndConditionalRenderNV glEndConditionalRenderNV;
	fp_glMultiTexCoord2bvOES glMultiTexCoord2bvOES;
	fp_glDeleteObjectARB glDeleteObjectARB;
	fp_glGetQueryivARB glGetQueryivARB;
	fp_glProgramNamedParameter4dvNV glProgramNamedParameter4dvNV;
	fp_glCompileCommandListNV glCompileCommandListNV;
	fp_glGetRenderbufferParameterivEXT glGetRenderbufferParameterivEXT;
	fp_glIsBufferResidentNV glIsBufferResidentNV;
	fp_glGetNamedRenderbufferParameterivEXT glGetNamedRenderbufferParameterivEXT;
	fp_glNamedFramebufferSampleLocationsfvARB glNamedFramebufferSampleLocationsfvARB;
	fp_glMultiTexGendvEXT glMultiTexGendvEXT;
	fp_glVertexArrayRangeNV glVertexArrayRangeNV;
	fp_glIsTextureHandleResidentNV glIsTextureHandleResidentNV;
	fp_glGetProgramEnvParameterdvARB glGetProgramEnvParameterdvARB;
	fp_glBlendEquationSeparateEXT glBlendEquationSeparateEXT;
	fp_glSecondaryColorFormatNV glSecondaryColorFormatNV;
	fp_glVertexAttrib4ubvNV glVertexAttrib4ubvNV;
	fp_glInvalidateTexSubImage glInvalidateTexSubImage;
	fp_glVDPAUUnregisterSurfaceNV glVDPAUUnregisterSurfaceNV;
	fp_glGetPerfQueryIdByNameINTEL glGetPerfQueryIdByNameINTEL;
	fp_glColor4ubVertex3fSUN glColor4ubVertex3fSUN;
	fp_glVertex2bOES glVertex2bOES;
	fp_glGetProgramEnvParameterfvARB glGetProgramEnvParameterfvARB;
	fp_glVertexAttrib4usvARB glVertexAttrib4usvARB;
	fp_glNamedFramebufferRenderbuffer glNamedFramebufferRenderbuffer;
	fp_glGetFloatIndexedvEXT glGetFloatIndexedvEXT;
	fp_glTestFenceAPPLE glTestFenceAPPLE;
	fp_glVertexAttribL2i64vNV glVertexAttribL2i64vNV;
	fp_glCallCommandListNV glCallCommandListNV;
	fp_glNamedStringARB glNamedStringARB;
	fp_glResetMinmaxEXT glResetMinmaxEXT;
	fp_glMatrixMult3x2fNV glMatrixMult3x2fNV;
	fp_glGetActiveSubroutineUniformName glGetActiveSubroutineUniformName;
	fp_glGetnHistogramARB glGetnHistogramARB;
	fp_glGetTextureLevelParameterfv glGetTextureLevelParameterfv;
	fp_glBitmapxOES glBitmapxOES;
	fp_glTextureSubImage1D glTextureSubImage1D;
	fp_glVertexAttribLPointerEXT glVertexAttribLPointerEXT;
	fp_glFogxvOES glFogxvOES;
	fp_glVertexAttribs2svNV glVertexAttribs2svNV;
	fp_glTextureImage3DEXT glTextureImage3DEXT;
	fp_glIsEnabledIndexedEXT glIsEnabledIndexedEXT;
	fp_glVertexPointerListIBM glVertexPointerListIBM;
	fp_glIsFenceNV glIsFenceNV;
	fp_glBeginPerfMonitorAMD glBeginPerfMonitorAMD;
	fp_glProgramUniformMatrix4x3dv glProgramUniformMatrix4x3dv;
	fp_glGetImageTransformParameterivHP glGetImageTransformParameterivHP;
	fp_glReadnPixels glReadnPixels;
	fp_glVertexAttribL3ui64NV glVertexAttribL3ui64NV;
	fp_glProgramUniform4fvEXT glProgramUniform4fvEXT;
	fp_glVertexAttrib2sARB glVertexAttrib2sARB;
	fp_glCompressedTexImage2DARB glCompressedTexImage2DARB;
	fp_glCheckFramebufferStatusEXT glCheckFramebufferStatusEXT;
	fp_glGetnMapivARB glGetnMapivARB;
	fp_glMultiTexCoord1ivARB glMultiTexCoord1ivARB;
	fp_glDisableVertexAttribArrayARB glDisableVertexAttribArrayARB;
	fp_glGetPathDashArrayNV glGetPathDashArrayNV;
	fp_glTexCoord4fVertex4fSUN glTexCoord4fVertex4fSUN;
	fp_glDeleteOcclusionQueriesNV glDeleteOcclusionQueriesNV;
	fp_glVertex4hvNV glVertex4hvNV;
	fp_glProgramLocalParameter4dARB glProgramLocalParameter4dARB;
	fp_glUnlockArraysEXT glUnlockArraysEXT;
	fp_glGetQueryObjectui64vEXT glGetQueryObjectui64vEXT;
	fp_glVertexAttribI4uivEXT glVertexAttribI4uivEXT;
	fp_glVertexStream4ivATI glVertexStream4ivATI;
	fp_glGetProgramResourceiv glGetProgramResourceiv;
	fp_glClearBufferData glClearBufferData;
	fp_glGetProgramivNV glGetProgramivNV;
	fp_glTransformFeedbackAttribsNV glTransformFeedbackAttribsNV;
	fp_glDeleteTransformFeedbacks glDeleteTransformFeedbacks;
	fp_glUniform4i64vARB glUniform4i64vARB;
	fp_glTextureSubImage2D glTextureSubImage2D;
	fp_glTextureStorage3DMultisampleEXT glTextureStorage3DMultisampleEXT;
	fp_glIndexxvOES glIndexxvOES;
	fp_glCompressedMultiTexImage1DEXT glCompressedMultiTexImage1DEXT;
	fp_glProgramUniform2ivEXT glProgramUniform2ivEXT;
	fp_glPushGroupMarkerEXT glPushGroupMarkerEXT;
	fp_glResolveDepthValuesNV glResolveDepthValuesNV;
	fp_glMultTransposeMatrixxOES glMultTransposeMatrixxOES;
	fp_glGetPixelMapxv glGetPixelMapxv;
	fp_glFramebufferSampleLocationsfvARB glFramebufferSampleLocationsfvARB;
	fp_glGetBooleanIndexedvEXT glGetBooleanIndexedvEXT;
	fp_glGetProgramSubroutineParameteruivNV glGetProgramSubroutineParameteruivNV;
	fp_glApplyFramebufferAttachmentCMAAINTEL glApplyFramebufferAttachmentCMAAINTEL;
	fp_glSelectPerfMonitorCountersAMD glSelectPerfMonitorCountersAMD;
	fp_glGetVertexAttribLi64vNV glGetVertexAttribLi64vNV;
	fp_glMultiTexCoord2dvARB glMultiTexCoord2dvARB;
	fp_glWeightuivARB glWeightuivARB;
	fp_glGetVideoCaptureStreamdvNV glGetVideoCaptureStreamdvNV;
	fp_glGetProgramLocalParameterdvARB glGetProgramLocalParameterdvARB;
	fp_glGetUniformui64vARB glGetUniformui64vARB;
	fp_glVertexStream4fvATI glVertexStream4fvATI;
	fp_glMakeImageHandleResidentARB glMakeImageHandleResidentARB;
	fp_glGetProgramNamedParameterfvNV glGetProgramNamedParameterfvNV;
	fp_glProgramUniform2i glProgramUniform2i;
	fp_glProgramUniform2d glProgramUniform2d;
	fp_glProgramLocalParametersI4uivNV glProgramLocalParametersI4uivNV;
	fp_glProgramUniform2f glProgramUniform2f;
	fp_glGetProgramBinary glGetProgramBinary;
	fp_glBinormal3iEXT glBinormal3iEXT;
	fp_glPauseTransformFeedback glPauseTransformFeedback;
	fp_glWindowPos2sMESA glWindowPos2sMESA;
	fp_glGlobalAlphaFactorbSUN glGlobalAlphaFactorbSUN;
	fp_glCreateTransformFeedbacks glCreateTransformFeedbacks;
	fp_glTexturePageCommitmentEXT glTexturePageCommitmentEXT;
	fp_glTransformFeedbackVaryingsNV glTransformFeedbackVaryingsNV;
	fp_glConvolutionParameterfvEXT glConvolutionParameterfvEXT;
	fp_glBlitFramebufferEXT glBlitFramebufferEXT;
	fp_glUniformMatrix4fvARB glUniformMatrix4fvARB;
	fp_glProgramEnvParameter4dvARB glProgramEnvParameter4dvARB;
	fp_glGetMultiTexLevelParameterivEXT glGetMultiTexLevelParameterivEXT;
	fp_glGetMaterialxvOES glGetMaterialxvOES;
	fp_glIsOcclusionQueryNV glIsOcclusionQueryNV;
	fp_glGetProgramEnvParameterIuivNV glGetProgramEnvParameterIuivNV;
	fp_glGetVertexArrayiv glGetVertexArrayiv;
	fp_glVertexAttrib4fvARB glVertexAttrib4fvARB;
	fp_glGetNamedProgramLocalParameterIivEXT glGetNamedProgramLocalParameterIivEXT;
	fp_glProgramUniform3uiEXT glProgramUniform3uiEXT;
	fp_glProgramUniformMatrix4x2dvEXT glProgramUniformMatrix4x2dvEXT;
	fp_glTexCoord1hvNV glTexCoord1hvNV;
	fp_glVariantdvEXT glVariantdvEXT;
	fp_glCullParameterfvEXT glCullParameterfvEXT;
	fp_glUniform3dv glUniform3dv;
	fp_glProgramUniform3fv glProgramUniform3fv;
	fp_glIsBufferARB glIsBufferARB;
	fp_glMultiTexCoord1bOES glMultiTexCoord1bOES;
	fp_glFogCoordhNV glFogCoordhNV;
	fp_glVertexAttrib4dvNV glVertexAttrib4dvNV;
	fp_glGenSymbolsEXT glGenSymbolsEXT;
	fp_glGetConvolutionFilter glGetConvolutionFilter;
	fp_glProgramUniform1fvEXT glProgramUniform1fvEXT;
	fp_glVertexAttrib1dvNV glVertexAttrib1dvNV;
	fp_glCompressedTexImage1DARB glCompressedTexImage1DARB;
	fp_glBindSamplers glBindSamplers;
	fp_glGetProgramEnvParameterIivNV glGetProgramEnvParameterIivNV;
	fp_glVertexAttribL4ui64vNV glVertexAttribL4ui64vNV;
	fp_glGetVideoivNV glGetVideoivNV;
	fp_glGetTextureImage glGetTextureImage;
	fp_glProgramUniform1fv glProgramUniform1fv;
	fp_glBeginFragmentShaderATI glBeginFragmentShaderATI;
	fp_glMultiDrawArraysEXT glMultiDrawArraysEXT;
	fp_glGenNamesAMD glGenNamesAMD;
	fp_glPathParameteriNV glPathParameteriNV;
	fp_glCreateCommandListsNV glCreateCommandListsNV;
	fp_glDeleteProgramPipelines glDeleteProgramPipelines;
	fp_glCopyColorSubTableEXT glCopyColorSubTableEXT;
	fp_glVariantsvEXT glVariantsvEXT;
	fp_glIsNameAMD glIsNameAMD;
	fp_glVertexArrayEdgeFlagOffsetEXT glVertexArrayEdgeFlagOffsetEXT;
	fp_glSecondaryColor3iEXT glSecondaryColor3iEXT;
	fp_glUniform4uivEXT glUniform4uivEXT;
	fp_glOrthoxOES glOrthoxOES;
	fp_glUniformSubroutinesuiv glUniformSubroutinesuiv;
	fp_glTexCoord2fColor3fVertex3fvSUN glTexCoord2fColor3fVertex3fvSUN;
	fp_glProgramUniform1i64vNV glProgramUniform1i64vNV;
	fp_glVertexAttribI4uiEXT glVertexAttribI4uiEXT;
	fp_glSecondaryColor3ubEXT glSecondaryColor3ubEXT;
	fp_glCompressedMultiTexSubImage1DEXT glCompressedMultiTexSubImage1DEXT;
	fp_glTangentPointerEXT glTangentPointerEXT;
	fp_glTexCoord2hNV glTexCoord2hNV;
	fp_glUniform1uivEXT glUniform1uivEXT;
	fp_glMatrixTranslatefEXT glMatrixTranslatefEXT;
	fp_glGetUniformuivEXT glGetUniformuivEXT;
	fp_glGetnPixelMapfvARB glGetnPixelMapfvARB;
	fp_glFramebufferTextureEXT glFramebufferTextureEXT;
	fp_glTexCoord2fColor3fVertex3fSUN glTexCoord2fColor3fVertex3fSUN;
	fp_glEvaluateDepthValuesARB glEvaluateDepthValuesARB;
	fp_glGetNamedBufferParameteriv glGetNamedBufferParameteriv;
	fp_glWindowPos2sARB glWindowPos2sARB;
	fp_glColor4fNormal3fVertex3fvSUN glColor4fNormal3fVertex3fvSUN;
	fp_glSeparableFilter2DEXT glSeparableFilter2DEXT;
	fp_glTexParameterxOES glTexParameterxOES;
	fp_glClearAccumxOES glClearAccumxOES;
	fp_glInvalidateFramebuffer glInvalidateFramebuffer;
	fp_glWeightubvARB glWeightubvARB;
	fp_glClearNamedFramebufferfi glClearNamedFramebufferfi;
	fp_glGetQueryBufferObjectuiv glGetQueryBufferObjectuiv;
	fp_glClearNamedFramebufferfv glClearNamedFramebufferfv;
	fp_glEndVertexShaderEXT glEndVertexShaderEXT;
	fp_glMultiTexCoord4dvARB glMultiTexCoord4dvARB;
	fp_glUniform1ui64vNV glUniform1ui64vNV;
	fp_glGetClipPlanefOES glGetClipPlanefOES;
	fp_glProgramUniform3ivEXT glProgramUniform3ivEXT;
	fp_glWeightivARB glWeightivARB;
	fp_glMultiTexCoord4hvNV glMultiTexCoord4hvNV;
	fp_glNormal3hNV glNormal3hNV;
	fp_glGetSeparableFilter glGetSeparableFilter;
	fp_glGetPathTexGenivNV glGetPathTexGenivNV;
	fp_glNamedBufferPageCommitmentARB glNamedBufferPageCommitmentARB;
	fp_glTexCoord4bOES glTexCoord4bOES;
	fp_glProgramParameter4dNV glProgramParameter4dNV;
	fp_glGetnMinmaxARB glGetnMinmaxARB;
	fp_glMultiTexCoord4hNV glMultiTexCoord4hNV;
	fp_glTextureBarrier glTextureBarrier;
	fp_glAlphaFragmentOp3ATI glAlphaFragmentOp3ATI;
	fp_glUniform1i64ARB glUniform1i64ARB;
	fp_glTexCoord2bvOES glTexCoord2bvOES;
	fp_glEvalCoord2xOES glEvalCoord2xOES;
	fp_glGetSharpenTexFuncSGIS glGetSharpenTexFuncSGIS;
	fp_glDebugMessageInsertKHR glDebugMessageInsertKHR;
	fp_glIglooInterfaceSGIX glIglooInterfaceSGIX;
	fp_glWindowPos2dvARB glWindowPos2dvARB;
	fp_glDrawArraysIndirect glDrawArraysIndirect;
	fp_glEnableVertexArrayAttrib glEnableVertexArrayAttrib;
	fp_glProgramUniformMatrix3x2dv glProgramUniformMatrix3x2dv;
	fp_glVertexStream4fATI glVertexStream4fATI;
	fp_glGetCoverageModulationTableNV glGetCoverageModulationTableNV;
	fp_glMultiDrawRangeElementArrayAPPLE glMultiDrawRangeElementArrayAPPLE;
	fp_glVertexAttribFormatNV glVertexAttribFormatNV;
	fp_glGetQueryBufferObjecti64v glGetQueryBufferObjecti64v;
	fp_glStartInstrumentsSGIX glStartInstrumentsSGIX;
	fp_glAreTexturesResidentEXT glAreTexturesResidentEXT;
	fp_glProgramUniformMatrix3x4dv glProgramUniformMatrix3x4dv;
	fp_glVideoCaptureStreamParameterdvNV glVideoCaptureStreamParameterdvNV;
	fp_glMapParameterivNV glMapParameterivNV;
	fp_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN;
	fp_glSecondaryColor3sEXT glSecondaryColor3sEXT;
	fp_glGetTexParameterIivEXT glGetTexParameterIivEXT;
	fp_glFrameTerminatorGREMEDY glFrameTerminatorGREMEDY;
	fp_glBlendBarrierKHR glBlendBarrierKHR;
	fp_glVertexAttrib4NubARB glVertexAttrib4NubARB;
	fp_glPrimitiveRestartNV glPrimitiveRestartNV;
	fp_glVertexAttribL1ui64vARB glVertexAttribL1ui64vARB;
	fp_glUniform1i64vNV glUniform1i64vNV;
	fp_glVertexAttribs4svNV glVertexAttribs4svNV;
	fp_glVertexAttrib2fvARB glVertexAttrib2fvARB;
	fp_glVertexAttribI4svEXT glVertexAttribI4svEXT;
	fp_glTextureImage3DMultisampleCoverageNV glTextureImage3DMultisampleCoverageNV;
	fp_glMemoryBarrier glMemoryBarrier;
	fp_glGetVariantArrayObjectfvATI glGetVariantArrayObjectfvATI;
	fp_glTexCoord4fColor4fNormal3fVertex4fvSUN glTexCoord4fColor4fNormal3fVertex4fvSUN;
	fp_glIsProgramARB glIsProgramARB;
	fp_glBindImageTextureEXT glBindImageTextureEXT;
	fp_glSampleCoveragexOES glSampleCoveragexOES;
	fp_glMultiTexCoord1svARB glMultiTexCoord1svARB;
	fp_glGetMapxvOES glGetMapxvOES;
	fp_glTextureStorage2DMultisampleEXT glTextureStorage2DMultisampleEXT;
	fp_glVertexAttrib4NbvARB glVertexAttrib4NbvARB;
	fp_glColorPointerEXT glColorPointerEXT;
	fp_glEnableClientStateiEXT glEnableClientStateiEXT;
	fp_glClearTexSubImage glClearTexSubImage;
	fp_glEvalCoord1xvOES glEvalCoord1xvOES;
	fp_glDetachObjectARB glDetachObjectARB;
	fp_glGetTextureParameterIiv glGetTextureParameterIiv;
	fp_glVariantusvEXT glVariantusvEXT;
	fp_glCompressedTextureImage3DEXT glCompressedTextureImage3DEXT;
	fp_glMultiTexCoord1dARB glMultiTexCoord1dARB;
	fp_glGetVertexArrayIntegeri_vEXT glGetVertexArrayIntegeri_vEXT;
	fp_glPixelTexGenParameterfSGIS glPixelTexGenParameterfSGIS;
	fp_glProgramUniformMatrix4x2dv glProgramUniformMatrix4x2dv;
	fp_glUniform3fARB glUniform3fARB;
	fp_glConvolutionParameteriv glConvolutionParameteriv;
	fp_glCopyMultiTexSubImage2DEXT glCopyMultiTexSubImage2DEXT;
	fp_glEnableVertexAttribArrayARB glEnableVertexAttribArrayARB;
	fp_glProgramUniformMatrix2x3fv glProgramUniformMatrix2x3fv;
	fp_glGetVertexAttribivARB glGetVertexAttribivARB;
	fp_glTexCoord4hvNV glTexCoord4hvNV;
	fp_glUseProgramObjectARB glUseProgramObjectARB;
	fp_glGetTextureParameteriv glGetTextureParameteriv;
	fp_glUniform3ui64vNV glUniform3ui64vNV;
	fp_glMatrixIndexusvARB glMatrixIndexusvARB;
	fp_glGetVideouivNV glGetVideouivNV;
	fp_glGetVideoCaptureivNV glGetVideoCaptureivNV;
	fp_glProgramUniform3ui glProgramUniform3ui;
	fp_glVertexAttrib3svARB glVertexAttrib3svARB;
	fp_glGetNamedBufferParameterivEXT glGetNamedBufferParameterivEXT;
	fp_glGenProgramPipelinesEXT glGenProgramPipelinesEXT;
	fp_glMatrixScaledEXT glMatrixScaledEXT;
	fp_glGetFragmentLightivSGIX glGetFragmentLightivSGIX;
	fp_glWindowPos2svARB glWindowPos2svARB;
	fp_glVertexAttrib2svNV glVertexAttrib2svNV;
	fp_glWindowPos2ivARB glWindowPos2ivARB;
	fp_glGetVertexAttribPointervNV glGetVertexAttribPointervNV;
	fp_glEdgeFlagPointerListIBM glEdgeFlagPointerListIBM;
	fp_glGenerateMipmapEXT glGenerateMipmapEXT;
	fp_glProgramUniformMatrix2x4dvEXT glProgramUniformMatrix2x4dvEXT;
	fp_glPathCoordsNV glPathCoordsNV;
	fp_glProgramUniform1i glProgramUniform1i;
	fp_glProgramUniform1d glProgramUniform1d;
	fp_glProgramUniform1f glProgramUniform1f;
	fp_glProgramParameteriEXT glProgramParameteriEXT;
	fp_glCompressedMultiTexImage2DEXT glCompressedMultiTexImage2DEXT;
	fp_glProgramUniform3iv glProgramUniform3iv;
	fp_glMultiTexCoord4xvOES glMultiTexCoord4xvOES;
	fp_glVertex3bvOES glVertex3bvOES;
	fp_glFramebufferReadBufferEXT glFramebufferReadBufferEXT;
	fp_glExtractComponentEXT glExtractComponentEXT;
	fp_glMinmax glMinmax;
	fp_glGenBuffersARB glGenBuffersARB;
	fp_glFogCoorddEXT glFogCoorddEXT;
	fp_glVertexAttrib4fvNV glVertexAttrib4fvNV;
	fp_glFragmentLightiSGIX glFragmentLightiSGIX;
	fp_glMultiTexCoord1bvOES glMultiTexCoord1bvOES;
	fp_glSecondaryColorPointerEXT glSecondaryColorPointerEXT;
	fp_glGetBufferSubDataARB glGetBufferSubDataARB;
	fp_glGetPathParameterivNV glGetPathParameterivNV;
	fp_glDisableVertexArrayAttrib glDisableVertexArrayAttrib;
	fp_glElementPointerATI glElementPointerATI;
	fp_glGetAttachedObjectsARB glGetAttachedObjectsARB;
	fp_glFogxOES glFogxOES;
	fp_glSharpenTexFuncSGIS glSharpenTexFuncSGIS;
	fp_glGetPerfMonitorGroupStringAMD glGetPerfMonitorGroupStringAMD;
	fp_glDeleteCommandListsNV glDeleteCommandListsNV;
	fp_glVertex4hNV glVertex4hNV;
	fp_glSecondaryColor3dvEXT glSecondaryColor3dvEXT;
	fp_glTextureStorage2DMultisample glTextureStorage2DMultisample;
	fp_glPathSubCoordsNV glPathSubCoordsNV;
	fp_glBlendFuncSeparateIndexedAMD glBlendFuncSeparateIndexedAMD;
	fp_glProgramStringARB glProgramStringARB;
	fp_glShaderOp2EXT glShaderOp2EXT;
	fp_glActiveTextureARB glActiveTextureARB;
	fp_glTexParameterIivEXT glTexParameterIivEXT;
	fp_glGetPerfQueryDataINTEL glGetPerfQueryDataINTEL;
	fp_glVertexAttrib4dvARB glVertexAttrib4dvARB;
	fp_glTextureSubImage1DEXT glTextureSubImage1DEXT;
	fp_glDispatchComputeGroupSizeARB glDispatchComputeGroupSizeARB;
	fp_glVertexAttrib2dvARB glVertexAttrib2dvARB;
	fp_glDepthBoundsdNV glDepthBoundsdNV;
	fp_glDeleteTexturesEXT glDeleteTexturesEXT;
	fp_glDrawBuffersATI glDrawBuffersATI;
	fp_glLightModelxvOES glLightModelxvOES;
	fp_glApplyTextureEXT glApplyTextureEXT;
	fp_glGetImageHandleNV glGetImageHandleNV;
	fp_glGetMinmax glGetMinmax;
	fp_glGetFixedvOES glGetFixedvOES;
	fp_glSamplePatternEXT glSamplePatternEXT;
	fp_glColor4fNormal3fVertex3fSUN glColor4fNormal3fVertex3fSUN;
	fp_glFogCoorddvEXT glFogCoorddvEXT;
	fp_glCopyTextureImage1DEXT glCopyTextureImage1DEXT;
	fp_glDeleteFencesNV glDeleteFencesNV;
	fp_glProgramUniform1ivEXT glProgramUniform1ivEXT;
	fp_glFlushStaticDataIBM glFlushStaticDataIBM;
	fp_glProgramUniform4ui64NV glProgramUniform4ui64NV;
	fp_glRasterPos4xOES glRasterPos4xOES;
	fp_glProgramUniform4dvEXT glProgramUniform4dvEXT;
	fp_glEndTransformFeedbackEXT glEndTransformFeedbackEXT;
	fp_glBinormal3dEXT glBinormal3dEXT;
	fp_glEndConditionalRenderNVX glEndConditionalRenderNVX;
	fp_glGetNamedRenderbufferParameteriv glGetNamedRenderbufferParameteriv;
	fp_glBindBuffersRange glBindBuffersRange;
	fp_glDrawCommandsAddressNV glDrawCommandsAddressNV;
	fp_glTexCoord2xvOES glTexCoord2xvOES;
	fp_glNamedFramebufferRenderbufferEXT glNamedFramebufferRenderbufferEXT;
	fp_glFlushVertexArrayRangeAPPLE glFlushVertexArrayRangeAPPLE;
	fp_glMultiTexCoord3dvARB glMultiTexCoord3dvARB;
	fp_glDebugMessageInsertARB glDebugMessageInsertARB;
	fp_glTextureSubImage3D glTextureSubImage3D;
	fp_glMatrixLoadTransposedEXT glMatrixLoadTransposedEXT;
	fp_glGetPointeri_vEXT glGetPointeri_vEXT;
	fp_glGetPerfMonitorCountersAMD glGetPerfMonitorCountersAMD;
	fp_glNamedBufferStorage glNamedBufferStorage;
	fp_glGenQueriesARB glGenQueriesARB;
	fp_glProgramUniform2ui64NV glProgramUniform2ui64NV;
	fp_glMultiTexCoord3bOES glMultiTexCoord3bOES;
	fp_glUniform1dv glUniform1dv;
	fp_glSecondaryColor3usvEXT glSecondaryColor3usvEXT;
	fp_glProgramEnvParameterI4uivNV glProgramEnvParameterI4uivNV;
	fp_glWindowPos4dMESA glWindowPos4dMESA;
	fp_glDebugMessageControlARB glDebugMessageControlARB;
	fp_glIsTextureEXT glIsTextureEXT;
	fp_glFragmentMaterialivSGIX glFragmentMaterialivSGIX;
	fp_glLinkProgramARB glLinkProgramARB;
	fp_glFinishFenceAPPLE glFinishFenceAPPLE;
	fp_glVertexArrayVertexAttribBindingEXT glVertexArrayVertexAttribBindingEXT;
	fp_glTextureParameteriEXT glTextureParameteriEXT;
	fp_glVariantivEXT glVariantivEXT;
	fp_glUnmapTexture2DINTEL glUnmapTexture2DINTEL;
	fp_glGetPointerIndexedvEXT glGetPointerIndexedvEXT;
	fp_glColor4xvOES glColor4xvOES;
	fp_glClampColorARB glClampColorARB;
	fp_glConvolutionFilter1D glConvolutionFilter1D;
	fp_glTransformFeedbackVaryingsEXT glTransformFeedbackVaryingsEXT;
	fp_glCombinerOutputNV glCombinerOutputNV;
	fp_glWindowPos4sMESA glWindowPos4sMESA;
	fp_glMultiTexCoord2ivARB glMultiTexCoord2ivARB;
	fp_glGetFenceivNV glGetFenceivNV;
	fp_glGetInfoLogARB glGetInfoLogARB;
	fp_glVertexAttribs3dvNV glVertexAttribs3dvNV;
	fp_glGlobalAlphaFactorsSUN glGlobalAlphaFactorsSUN;
	fp_glGetTrackMatrixivNV glGetTrackMatrixivNV;
	fp_glTextureParameterfvEXT glTextureParameterfvEXT;
	fp_glIsNamedBufferResidentNV glIsNamedBufferResidentNV;
	fp_glProgramUniform4ui64vARB glProgramUniform4ui64vARB;
	fp_glTbufferMask3DFX glTbufferMask3DFX;
	fp_glCoverFillPathNV glCoverFillPathNV;
	fp_glObjectLabelKHR glObjectLabelKHR;
	fp_glVertexAttrib1fvARB glVertexAttrib1fvARB;
	fp_glGenerateTextureMipmap glGenerateTextureMipmap;
	fp_glNamedProgramLocalParameterI4uivEXT glNamedProgramLocalParameterI4uivEXT;
	fp_glProgramSubroutineParametersuivNV glProgramSubroutineParametersuivNV;
	fp_glSampleMaskIndexedNV glSampleMaskIndexedNV;
	fp_glMemoryBarrierEXT glMemoryBarrierEXT;
	fp_glVertexAttrib3svNV glVertexAttrib3svNV;
	fp_glVertexStream3iATI glVertexStream3iATI;
	fp_glCopyConvolutionFilter1D glCopyConvolutionFilter1D;
	fp_glTexParameterxvOES glTexParameterxvOES;
	fp_glNamedFramebufferParameteriEXT glNamedFramebufferParameteriEXT;
	fp_glInvalidateTexImage glInvalidateTexImage;
	fp_glVertexAttribI4usvEXT glVertexAttribI4usvEXT;
	fp_glTextureBufferRangeEXT glTextureBufferRangeEXT;
	fp_glIsPathNV glIsPathNV;
	fp_glGetnUniformi64vARB glGetnUniformi64vARB;
	fp_glFramebufferTextureMultiviewOVR glFramebufferTextureMultiviewOVR;
	fp_glCompressedMultiTexSubImage2DEXT glCompressedMultiTexSubImage2DEXT;
	fp_glDebugMessageCallback glDebugMessageCallback;
	fp_glTangent3svEXT glTangent3svEXT;
	fp_glVertexAttribParameteriAMD glVertexAttribParameteriAMD;
	fp_glCreateSyncFromCLeventARB glCreateSyncFromCLeventARB;
	fp_glGetVertexAttribLui64vARB glGetVertexAttribLui64vARB;
	fp_glVertexAttribL4ui64NV glVertexAttribL4ui64NV;
	fp_glReplacementCodeuiColor4ubVertex3fSUN glReplacementCodeuiColor4ubVertex3fSUN;
	fp_glVertexPointervINTEL glVertexPointervINTEL;
	fp_glCreateShaderProgramvEXT glCreateShaderProgramvEXT;
	fp_glVertex2bvOES glVertex2bvOES;
	fp_glGetMapControlPointsNV glGetMapControlPointsNV;
	fp_glTextureParameterIiv glTextureParameterIiv;
	fp_glBindBufferRangeNV glBindBufferRangeNV;
	fp_glVertexStream3dvATI glVertexStream3dvATI;
	fp_glNormalPointerListIBM glNormalPointerListIBM;
	fp_glProgramUniform2dvEXT glProgramUniform2dvEXT;
	fp_glVertexStream3ivATI glVertexStream3ivATI;
	fp_glGetNamedFramebufferAttachmentParameterivEXT glGetNamedFramebufferAttachmentParameterivEXT;
	fp_glVertexArrayVertexAttribIFormatEXT glVertexArrayVertexAttribIFormatEXT;
	fp_glGetTextureImageEXT glGetTextureImageEXT;
	fp_glMultiDrawArraysIndirect glMultiDrawArraysIndirect;
	fp_glProgramUniform1i64vARB glProgramUniform1i64vARB;
	fp_glFramebufferTextureARB glFramebufferTextureARB;
	fp_glPushClientAttribDefaultEXT glPushClientAttribDefaultEXT;
	fp_glVertexAttrib4svNV glVertexAttrib4svNV;
	fp_glGetConvolutionParameterxvOES glGetConvolutionParameterxvOES;
	fp_glGetProgramResourceName glGetProgramResourceName;
	fp_glCopyColorTable glCopyColorTable;
	fp_glDepthRangeArrayv glDepthRangeArrayv;
	fp_glCoverFillPathInstancedNV glCoverFillPathInstancedNV;
	fp_glMultiTexParameterivEXT glMultiTexParameterivEXT;
	fp_glGetActiveAtomicCounterBufferiv glGetActiveAtomicCounterBufferiv;
	fp_glVertexAttrib4fNV glVertexAttrib4fNV;
	fp_glGetColorTableParameterivSGI glGetColorTableParameterivSGI;
	fp_glVertexArrayAttribBinding glVertexArrayAttribBinding;
	fp_glProgramParameters4dvNV glProgramParameters4dvNV;
	fp_glVertexAttribL4dv glVertexAttribL4dv;
	fp_glVertexStream3dATI glVertexStream3dATI;
	fp_glVertexAttribDivisorARB glVertexAttribDivisorARB;
	fp_glProgramUniform1dv glProgramUniform1dv;
	fp_glProgramUniform3i64vNV glProgramUniform3i64vNV;
	fp_glTangent3fEXT glTangent3fEXT;
	fp_glGetPathMetricRangeNV glGetPathMetricRangeNV;
	fp_glWindowPos2iMESA glWindowPos2iMESA;
	fp_glVertex2xvOES glVertex2xvOES;
	fp_glReplacementCodeuiVertex3fSUN glReplacementCodeuiVertex3fSUN;
	fp_glWindowPos3fARB glWindowPos3fARB;
	fp_glMapNamedBufferEXT glMapNamedBufferEXT;
	fp_glIsPointInFillPathNV glIsPointInFillPathNV;
	fp_glVertexAttribI2uiEXT glVertexAttribI2uiEXT;
	fp_glProgramUniform4uiv glProgramUniform4uiv;
	fp_glGetConvolutionParameterfvEXT glGetConvolutionParameterfvEXT;
	fp_glFramebufferRenderbufferEXT glFramebufferRenderbufferEXT;
	fp_glBinormal3svEXT glBinormal3svEXT;
	fp_glBindBufferOffsetNV glBindBufferOffsetNV;
	fp_glCopyTextureSubImage2D glCopyTextureSubImage2D;
	fp_glGetProgramResourcefvNV glGetProgramResourcefvNV;
	fp_glBinormalPointerEXT glBinormalPointerEXT;
	fp_glUniform2ivARB glUniform2ivARB;
	fp_glGetHistogramParameterfvEXT glGetHistogramParameterfvEXT;
	fp_glGetProgramStringNV glGetProgramStringNV;
	fp_glGetTextureSamplerHandleNV glGetTextureSamplerHandleNV;
	fp_glGetColorTableParameteriv glGetColorTableParameteriv;
	fp_glObjectPurgeableAPPLE glObjectPurgeableAPPLE;
	fp_glColorTableSGI glColorTableSGI;
	fp_glWindowPos2fvMESA glWindowPos2fvMESA;
	fp_glGetnUniformivKHR glGetnUniformivKHR;
	fp_glPolygonOffsetxOES glPolygonOffsetxOES;
	fp_glUniform4i64NV glUniform4i64NV;
	fp_glUniformHandleui64vARB glUniformHandleui64vARB;
	fp_glFragmentLightModelfvSGIX glFragmentLightModelfvSGIX;
	fp_glPointParameterxvOES glPointParameterxvOES;
	fp_glBindFragmentShaderATI glBindFragmentShaderATI;
	fp_glVertexAttribs3hvNV glVertexAttribs3hvNV;
	fp_glListParameterfvSGIX glListParameterfvSGIX;
	fp_glNamedRenderbufferStorageMultisample glNamedRenderbufferStorageMultisample;
	fp_glClearNamedBufferData glClearNamedBufferData;
	fp_glLightModelxOES glLightModelxOES;
	fp_glVertexBlendEnviATI glVertexBlendEnviATI;
	fp_glMultiDrawElementArrayAPPLE glMultiDrawElementArrayAPPLE;
	fp_glStencilFillPathInstancedNV glStencilFillPathInstancedNV;
	fp_glVDPAUUnmapSurfacesNV glVDPAUUnmapSurfacesNV;
	fp_glProgramUniform4i64NV glProgramUniform4i64NV;
	fp_glVertexStream4dvATI glVertexStream4dvATI;
	fp_glProgramUniformMatrix4fvEXT glProgramUniformMatrix4fvEXT;
	fp_glVertexAttrib3hNV glVertexAttrib3hNV;
	fp_glFlushMappedNamedBufferRange glFlushMappedNamedBufferRange;
	fp_glBindTransformFeedbackNV glBindTransformFeedbackNV;
	fp_glNamedBufferPageCommitmentEXT glNamedBufferPageCommitmentEXT;
	fp_glCopyTexSubImage3DEXT glCopyTexSubImage3DEXT;
	fp_glGetObjectBufferfvATI glGetObjectBufferfvATI;
	fp_glDrawElementsInstancedEXT glDrawElementsInstancedEXT;
	fp_glNamedProgramLocalParameterI4iEXT glNamedProgramLocalParameterI4iEXT;
	fp_glGetProgramStageiv glGetProgramStageiv;
	fp_glGetMaterialxOES glGetMaterialxOES;
	fp_glGetVideoui64vNV glGetVideoui64vNV;
	fp_glTangent3bEXT glTangent3bEXT;
	fp_glGetGraphicsResetStatusARB glGetGraphicsResetStatusARB;
	fp_glProgramUniformHandleui64NV glProgramUniformHandleui64NV;
	fp_glUniform4d glUniform4d;
	fp_glCreateProgramPipelines glCreateProgramPipelines;
	fp_glVertexAttribLPointer glVertexAttribLPointer;
	fp_glSampleMaskSGIS glSampleMaskSGIS;
	fp_glPixelTransformParameterfvEXT glPixelTransformParameterfvEXT;
	fp_glDrawTransformFeedbackNV glDrawTransformFeedbackNV;
	fp_glTextureImage2DMultisampleCoverageNV glTextureImage2DMultisampleCoverageNV;
	fp_glNamedRenderbufferStorageMultisampleCoverageEXT glNamedRenderbufferStorageMultisampleCoverageEXT;
	fp_glGetActiveSubroutineName glGetActiveSubroutineName;
	fp_glPopDebugGroup glPopDebugGroup;
	fp_glWindowPos2svMESA glWindowPos2svMESA;
	fp_glGenerateTextureMipmapEXT glGenerateTextureMipmapEXT;
	fp_glVertexAttribArrayObjectATI glVertexAttribArrayObjectATI;
	fp_glTexCoord3bOES glTexCoord3bOES;
	fp_glProgramUniformMatrix3x2fv glProgramUniformMatrix3x2fv;
	fp_glUniform2fvARB glUniform2fvARB;
	fp_glProgramLocalParameterI4uivNV glProgramLocalParameterI4uivNV;
	fp_glFlushVertexArrayRangeNV glFlushVertexArrayRangeNV;
	fp_glSecondaryColor3svEXT glSecondaryColor3svEXT;
	fp_glGetQueryIndexediv glGetQueryIndexediv;
	fp_glFramebufferTexture3DEXT glFramebufferTexture3DEXT;
	fp_glObjectLabel glObjectLabel;
	fp_glDeleteTransformFeedbacksNV glDeleteTransformFeedbacksNV;
	fp_glGetCompressedTextureImageEXT glGetCompressedTextureImageEXT;
	fp_glIndexMaterialEXT glIndexMaterialEXT;
	fp_glTexCoord2hvNV glTexCoord2hvNV;
	fp_glFramebufferTexture2DEXT glFramebufferTexture2DEXT;
	fp_glEndTransformFeedbackNV glEndTransformFeedbackNV;
	fp_glGlobalAlphaFactoruiSUN glGlobalAlphaFactoruiSUN;
	fp_glCompileShaderARB glCompileShaderARB;
	fp_glNamedBufferSubDataEXT glNamedBufferSubDataEXT;
	fp_glFlushRasterSGIX glFlushRasterSGIX;
	fp_glUniform4ui64vARB glUniform4ui64vARB;
	fp_glGetObjectLabelKHR glGetObjectLabelKHR;
	fp_glNormalStream3fATI glNormalStream3fATI;
	fp_glProgramUniformMatrix2fv glProgramUniformMatrix2fv;
	fp_glVertexAttribs1hvNV glVertexAttribs1hvNV;
	fp_glWindowPos4svMESA glWindowPos4svMESA;
	fp_glDeleteFragmentShaderATI glDeleteFragmentShaderATI;
	fp_glUniform1i64NV glUniform1i64NV;
	fp_glPathStringNV glPathStringNV;
	fp_glGetNamedFramebufferParameterivEXT glGetNamedFramebufferParameterivEXT;
	fp_glGetProgramNamedParameterdvNV glGetProgramNamedParameterdvNV;
	fp_glPathDashArrayNV glPathDashArrayNV;
	fp_glColor3fVertex3fvSUN glColor3fVertex3fvSUN;
	fp_glGetImageHandleARB glGetImageHandleARB;
	fp_glTangent3dEXT glTangent3dEXT;
	fp_glGetQueryObjectivARB glGetQueryObjectivARB;
	fp_glGetLocalConstantFloatvEXT glGetLocalConstantFloatvEXT;
	fp_glUseShaderProgramEXT glUseShaderProgramEXT;
	fp_glBindRenderbufferEXT glBindRenderbufferEXT;
	fp_glGetnUniformiv glGetnUniformiv;
	fp_glClearDepthfOES glClearDepthfOES;
	fp_glClearColorIuiEXT glClearColorIuiEXT;
	fp_glGetProgramResourceIndex glGetProgramResourceIndex;
	fp_glConvolutionFilter2DEXT glConvolutionFilter2DEXT;
	fp_glGetVariantArrayObjectivATI glGetVariantArrayObjectivATI;
	fp_glVertexAttrib1dARB glVertexAttrib1dARB;
	fp_glGetNamedBufferPointerv glGetNamedBufferPointerv;
	fp_glLockArraysEXT glLockArraysEXT;
	fp_glVertexAttribPointerNV glVertexAttribPointerNV;
	fp_glBindBufferBaseEXT glBindBufferBaseEXT;
	fp_glProgramUniform1fEXT glProgramUniform1fEXT;
	fp_glGetQueryBufferObjectui64v glGetQueryBufferObjectui64v;
	fp_glSetMultisamplefvAMD glSetMultisamplefvAMD;
	fp_glPathColorGenNV glPathColorGenNV;
	fp_glUniform1ivARB glUniform1ivARB;
	fp_glVertexAttrib4ivARB glVertexAttrib4ivARB;
	fp_glGenTransformFeedbacks glGenTransformFeedbacks;
	fp_glPixelTransformParameterfEXT glPixelTransformParameterfEXT;
	fp_glGetTexParameterIuivEXT glGetTexParameterIuivEXT;
	fp_glGetObjectParameterivARB glGetObjectParameterivARB;
	fp_glVertexArraySecondaryColorOffsetEXT glVertexArraySecondaryColorOffsetEXT;
	fp_glWindowPos2fARB glWindowPos2fARB;
	fp_glCompressedTexSubImage3DARB glCompressedTexSubImage3DARB;
	fp_glProgramBinary glProgramBinary;
	fp_glPresentFrameKeyedNV glPresentFrameKeyedNV;
	fp_glPathCoverDepthFuncNV glPathCoverDepthFuncNV;
	fp_glTransformFeedbackStreamAttribsNV glTransformFeedbackStreamAttribsNV;
	fp_glSecondaryColor3usEXT glSecondaryColor3usEXT;
	fp_glCopyColorTableSGI glCopyColorTableSGI;
	fp_glProgramEnvParameter4fvARB glProgramEnvParameter4fvARB;
	fp_glGetObjectPtrLabelKHR glGetObjectPtrLabelKHR;
	fp_glMultiTexCoord4sARB glMultiTexCoord4sARB;
	fp_glGetVertexArrayIndexed64iv glGetVertexArrayIndexed64iv;
	fp_glMatrixMultTranspose3x3fNV glMatrixMultTranspose3x3fNV;
	fp_glVertexArrayAttribFormat glVertexArrayAttribFormat;
	fp_glVertexStream2fvATI glVertexStream2fvATI;
	fp_glDrawCommandsStatesAddressNV glDrawCommandsStatesAddressNV;
	fp_glUniform4ui64NV glUniform4ui64NV;
	fp_glBindTextureEXT glBindTextureEXT;
	fp_glGetFinalCombinerInputParameterfvNV glGetFinalCombinerInputParameterfvNV;
	fp_glMultiTexCoord3bvOES glMultiTexCoord3bvOES;
	fp_glGetCompressedTextureImage glGetCompressedTextureImage;
	fp_glBindTexGenParameterEXT glBindTexGenParameterEXT;
	fp_glNormalStream3bATI glNormalStream3bATI;
	fp_glTextureImage2DEXT glTextureImage2DEXT;
	fp_glTexCoord4xOES glTexCoord4xOES;
	fp_glSecondaryColor3fvEXT glSecondaryColor3fvEXT;
	fp_glDepthRangedNV glDepthRangedNV;
	fp_glGetUniformi64vARB glGetUniformi64vARB;
	fp_glProgramNamedParameter4fvNV glProgramNamedParameter4fvNV;
	fp_glVertexStream1dATI glVertexStream1dATI;
	fp_glUniform1fARB glUniform1fARB;
	fp_glNamedFramebufferTexture1DEXT glNamedFramebufferTexture1DEXT;
	fp_glMultiDrawElementsIndirectCountARB glMultiDrawElementsIndirectCountARB;
	fp_glProgramUniformMatrix4x2fv glProgramUniformMatrix4x2fv;
	fp_glGetTextureParameterIivEXT glGetTextureParameterIivEXT;
	fp_glMultiTexCoord3hNV glMultiTexCoord3hNV;
	fp_glNamedProgramLocalParametersI4uivEXT glNamedProgramLocalParametersI4uivEXT;
	fp_glTexCoord2fColor4fNormal3fVertex3fSUN glTexCoord2fColor4fNormal3fVertex3fSUN;
	fp_glGenTransformFeedbacksNV glGenTransformFeedbacksNV;
	fp_glCombinerParameterivNV glCombinerParameterivNV;
	fp_glCopyMultiTexImage2DEXT glCopyMultiTexImage2DEXT;
	fp_glVertexAttrib4ubNV glVertexAttrib4ubNV;
	fp_glTexImage3DMultisampleCoverageNV glTexImage3DMultisampleCoverageNV;
	fp_glGetShaderPrecisionFormat glGetShaderPrecisionFormat;
	fp_glTexSubImage4DSGIS glTexSubImage4DSGIS;
	fp_glRasterSamplesEXT glRasterSamplesEXT;
	fp_glTextureView glTextureView;
	fp_glEvalMapsNV glEvalMapsNV;
	fp_glGetFragDataLocationEXT glGetFragDataLocationEXT;
	fp_glGetCompressedMultiTexImageEXT glGetCompressedMultiTexImageEXT;
	fp_glDrawBuffersARB glDrawBuffersARB;
	fp_glGetVertexAttribfvNV glGetVertexAttribfvNV;
	fp_glGetNamedBufferParameteri64v glGetNamedBufferParameteri64v;
	fp_glCommandListSegmentsNV glCommandListSegmentsNV;
	fp_glTextureParameterIivEXT glTextureParameterIivEXT;
	fp_glMultiTexParameterfvEXT glMultiTexParameterfvEXT;
	fp_glProgramUniform2ui64ARB glProgramUniform2ui64ARB;
	fp_glNewObjectBufferATI glNewObjectBufferATI;
	fp_glRotatexOES glRotatexOES;
	fp_glTextureImage1DEXT glTextureImage1DEXT;
	fp_glAttachObjectARB glAttachObjectARB;
	fp_glCopyTexSubImage1DEXT glCopyTexSubImage1DEXT;
	fp_glUniformMatrix3fvARB glUniformMatrix3fvARB;
	fp_glMakeBufferResidentNV glMakeBufferResidentNV;
	fp_glPointParameterfvEXT glPointParameterfvEXT;
	fp_glUniform4fARB glUniform4fARB;
	fp_glVertexAttribs3fvNV glVertexAttribs3fvNV;
	fp_glCopyTextureSubImage3D glCopyTextureSubImage3D;
	fp_glMultiTexEnvfvEXT glMultiTexEnvfvEXT;
	fp_glDrawRangeElementArrayATI glDrawRangeElementArrayATI;
	fp_glDrawArraysInstancedARB glDrawArraysInstancedARB;
	fp_glGetDebugMessageLogARB glGetDebugMessageLogARB;
	fp_glGetPathTexGenfvNV glGetPathTexGenfvNV;
	fp_glNamedProgramLocalParameters4fvEXT glNamedProgramLocalParameters4fvEXT;
	fp_glCopyConvolutionFilter2DEXT glCopyConvolutionFilter2DEXT;
	fp_glCompressedTextureSubImage2DEXT glCompressedTextureSubImage2DEXT;
	fp_glReplacementCodeubSUN glReplacementCodeubSUN;
	fp_glFragmentMaterialiSGIX glFragmentMaterialiSGIX;
	fp_glReadInstrumentsSGIX glReadInstrumentsSGIX;
	fp_glBindBufferARB glBindBufferARB;
	fp_glVertexAttrib1sNV glVertexAttrib1sNV;
	fp_glBeginOcclusionQueryNV glBeginOcclusionQueryNV;
	fp_glGenFencesAPPLE glGenFencesAPPLE;
	fp_glScissorIndexedv glScissorIndexedv;
	fp_glDisableVariantClientStateEXT glDisableVariantClientStateEXT;
	fp_glMinmaxEXT glMinmaxEXT;
	fp_glNormalPointervINTEL glNormalPointervINTEL;
	fp_glGetObjectParameterivAPPLE glGetObjectParameterivAPPLE;
	fp_glVertexAttrib3sARB glVertexAttrib3sARB;
	fp_glUpdateObjectBufferATI glUpdateObjectBufferATI;
	fp_glGetUniformBufferSizeEXT glGetUniformBufferSizeEXT;
	fp_glProgramUniform3i64ARB glProgramUniform3i64ARB;
	fp_glBindProgramPipelineEXT glBindProgramPipelineEXT;
	fp_glNormal3fVertex3fSUN glNormal3fVertex3fSUN;
	fp_glMultiDrawElementsEXT glMultiDrawElementsEXT;
	fp_glGetTransformFeedbackVaryingEXT glGetTransformFeedbackVaryingEXT;
	fp_glPushDebugGroupKHR glPushDebugGroupKHR;
	fp_glMultiTexCoord2bOES glMultiTexCoord2bOES;
	fp_glEvalCoord1xOES glEvalCoord1xOES;
	fp_glDrawArraysInstancedBaseInstance glDrawArraysInstancedBaseInstance;
	fp_glIsPointInStrokePathNV glIsPointInStrokePathNV;
}
